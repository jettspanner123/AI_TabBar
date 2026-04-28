from fastapi import APIRouter

from Controllers.AIOutputController import AIOutputController
from Models.Response.BaseResponse import BaseResponse

AIOutputRouter = APIRouter(prefix="/ai", tags=["AI", "Intelligence"])
AIOutputController = AIOutputController()

class AIOutputRoute:

    @staticmethod
    @AIOutputRouter.get("/health-check")
    def health_check() -> BaseResponse:
        AIOutputController.health_check()
        return BaseResponse.success("AI Output Route is healthy.")
