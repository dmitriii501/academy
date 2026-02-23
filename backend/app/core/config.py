from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = "prototype_app_backend"
    api_v1_prefix: str = "/api"

    # Database
    database_url: str = "postgresql+psycopg2://postgres:postgres@db:5432/prototype_app"

    # Auth
    jwt_secret: str = "change_me_in_prod"
    jwt_algorithm: str = "HS256"
    access_token_expires_minutes: int = 60
    refresh_token_expires_minutes: int = 60 * 24 * 14

    # Schedule cache
    schedule_cache_ttl_seconds: int = 600

    class Config:
        env_file = ".env"


settings = Settings()
