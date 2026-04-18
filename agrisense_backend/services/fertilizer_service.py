import os
import json
from dotenv import load_dotenv

load_dotenv()

try:
    from google import genai
    from google.genai import types

    _HAS_NEW_GENAI = True
except ImportError:
    import importlib

    genai = importlib.import_module("google.generativeai")
    _HAS_NEW_GENAI = False


def _extract_json(text: str):
    if not text:
        raise ValueError("Empty model response")


    cleaned = text.replace("```json", "").replace("```", "").strip()
    start = cleaned.find("{")
    end = cleaned.rfind("}")

    if start == -1 or end == -1 or end <= start:
        raise ValueError("No JSON object found in model response")

    return json.loads(cleaned[start : end + 1])


def _is_quota_error(error_text: str) -> bool:
    quota_markers = [
        "429",
        "quota",
        "rate limit",
        "resourceexhausted",
        "too many requests",
    ]
    lowered = (error_text or "").lower()
    return any(marker in lowered for marker in quota_markers)


def _normalize_number(value):
    if isinstance(value, (int, float)):
        return float(value)

    if isinstance(value, str):
        cleaned = value.strip().replace(",", "")
        if cleaned:
            return float(cleaned)

    raise ValueError("Invalid numeric value in model response")


def _is_reasonable_cost(total_quantity: float, estimated_cost: float) -> bool:
    if total_quantity <= 0 or estimated_cost <= 0:
        return False

    unit_cost = estimated_cost / total_quantity
    return 25 <= unit_cost <= 5000


def _build_prompt(crop_type: str, land_size: float, previous_cost: float | None = None) -> str:
    cost_rules = """
Use a conservative Sri Lankan retail estimate for fertilizer cost.
estimated_cost must be the total cost in LKR for the full quantity only.
Do not output import-grade or premium retail extremes.
Do not include transport, labor, or taxes.
Round to the nearest whole number.
""".strip()

    correction_note = ""
    if previous_cost is not None:
        correction_note = f"""
The previous cost estimate {previous_cost} LKR was unrealistic.
Return a more grounded local-market estimate.
""".strip()

    return f"""
Give fertilizer recommendation for {crop_type} in Sri Lanka for {land_size} acres.

{cost_rules}
{correction_note}

Return ONLY JSON:
{{
  "crop_type": "",
  "fertilizer_name": "",
  "npk_ratio": "",
  "total_quantity": number,
  "estimated_cost": number,
  "usage_steps": [],
  "application_timing": ""
}}
"""


def _call_gemini(api_key: str, model_name: str, prompt: str) -> str:
    if _HAS_NEW_GENAI:
        client = genai.Client(api_key=api_key)
        response = client.models.generate_content(
            model=model_name,
            contents=prompt,
            config=types.GenerateContentConfig(
                response_mime_type="application/json",
                temperature=0.2,
            ),
        )
        return (response.text or "").strip()

    genai.configure(api_key=api_key)
    model = genai.GenerativeModel(model_name)
    response = model.generate_content(
        prompt,
        generation_config={"response_mime_type": "application/json"},
    )
    return (response.text or "").strip()


def _parse_recommendation(text: str) -> dict:
    payload = _extract_json(text)
    payload["total_quantity"] = _normalize_number(payload["total_quantity"])
    payload["estimated_cost"] = _normalize_number(payload["estimated_cost"])
    return payload


def get_fertilizer_recommendation(crop_type: str, land_size: float, model_name: str):
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        return {"error": "GEMINI_API_KEY is missing in backend environment"}

    models = [
        (model_name or "").strip(),
        "gemini-2.5-flash",
        "gemini-2.0-flash",
        "gemini-2.0-flash-lite",
    ]

    # Keep order, remove empty values and duplicates so retries are deterministic.
    models = [m for m in dict.fromkeys(models) if m]

    all_errors = []

    for m in models:
        previous_cost = None

        for attempt in range(2):
            prompt = _build_prompt(crop_type, land_size, previous_cost)

            try:
                text = _call_gemini(api_key, m, prompt)
                recommendation = _parse_recommendation(text)

                if not _is_reasonable_cost(
                    recommendation["total_quantity"], recommendation["estimated_cost"]
                ):
                    previous_cost = recommendation["estimated_cost"]
                    continue

                return recommendation
            except Exception as exc:
                all_errors.append(f"{m} attempt {attempt + 1}: {exc}")
                break

        all_errors.append(f"{m}: unrealistic fertilizer cost returned by model")

    if any(_is_quota_error(err) for err in all_errors):
        return {
            "error": "Gemini quota exceeded. Please try again later or use a different API key.",
            "status_code": 429,
        }

    return {
        "error": "AI recommendation failed. Please try again later.",
        "status_code": 502,
    }