from pydantic import BaseModel


class BaseResponse(BaseModel):
    success: bool
    message: str

    @staticmethod
    def success(message: str) -> BaseResponse:
        return BaseResponse(success=True, message=message)

    @staticmethod
    def failure(message: str) -> BaseResponse:
        return BaseResponse(success=False, message=message)