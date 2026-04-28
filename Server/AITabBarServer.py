from fastapi import FastAPI

from Configuration.AppRootServerConfiguration import AppRootServerConfiguration
from Routes.AIOutputRoute import AIOutputRouter

app_server: FastAPI = AppRootServerConfiguration.get_app_server()

app_server.include_router(AIOutputRouter)