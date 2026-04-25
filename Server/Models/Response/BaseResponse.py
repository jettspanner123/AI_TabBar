from pydantic import BaseModel


class BaseResponse(BaseModel):
    success: bool
    message: str

    @staticmethod
    def success(message: str) -> BaseResponse:
        return BaseResponse(success=True, message=message)