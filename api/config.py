from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    # .env dosyasındaki değişken adlarıyla EŞLEŞMELİ
    DB_USER: str
    DB_PASSWORD: str
    DB_HOST: str
    DB_PORT: int
    DB_NAME: str

    model_config = SettingsConfigDict(env_file=".env")

# Bu settings nesnesini projemizin her yerinde kullanacağız
settings = Settings()