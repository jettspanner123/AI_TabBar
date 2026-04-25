from fastapi import FastAPI
from uvicorn import run as RunFastAPI

class AppRootServerConfiguration:

    @staticmethod
    def get_app_server():
        return FastAPI()

    @staticmethod
    def run_app_server() -> None:
        RunFastAPI("main:app", host="0.0.0.0", port=8080)
