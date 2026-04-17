from fastapi import APIRouter
from fastapi.responses import JSONResponse
from models.fertilizer_model import FertilizerRequest
from services.fertilizer_service import get_fertilizer_recommendation

router = APIRouter()

@router.post("/fertilizer")
def fertilizer(req: FertilizerRequest):
    result = get_fertilizer_recommendation(
        req.crop_type,
        req.land_size,
        req.model,
    )

    if isinstance(result, dict) and "status_code" in result:
        status_code = int(result.pop("status_code"))
        return JSONResponse(status_code=status_code, content=result)

    return result