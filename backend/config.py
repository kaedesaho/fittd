import os

class Config:
    JWT_SECRET_KEY = os.environ.get("JWT_SECRET_KEY", "change-this-secret-in-production")
    DB_PATH = os.environ.get("DB_PATH", "users.db")
