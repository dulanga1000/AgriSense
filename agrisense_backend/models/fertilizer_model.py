from typing import Optional

from pydantic import BaseModel

class FertilizerRequest(BaseModel):
    crop_type: str
    land_size: float
    model: Optional[str] = None