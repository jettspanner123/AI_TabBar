from fastapi import FastAPI

from Configuration.AppRootServerConfiguration import AppRootServerConfiguration

app_server: FastAPI = AppRootServerConfiguration.get_app_server()

if __name__ == "__main__":
    AppRootServerConfiguration.run_app_server()

