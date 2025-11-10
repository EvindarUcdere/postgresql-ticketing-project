import psycopg2
from fastapi import FastAPI, Depends, HTTPException
from config import settings  # Ayar dosyamızı import et


app = FastAPI(title="Bilet Sistemi API", version="1.0")



def get_db_connection():
    
    conn = psycopg2.connect(
        host=settings.DB_HOST,
        database=settings.DB_NAME,
        user=settings.DB_USER,
        password=settings.DB_PASSWORD,
        port=settings.DB_PORT
    )
    try:
       
        yield conn
    finally:
      
        conn.close()


DbConnection = Depends(get_db_connection)



@app.get("/")
def read_root():
    return {"message": "Bilet API sunucusu çalışıyor! Veritabanı bağlantısını test etmek için /db-test adresine gidin."}


@app.get("/db-test")
def test_database_connection(conn = DbConnection):
    """
    Veritabanı bağlantısını test eder ve şu anki saati döndürür.
    """
    try:
       
        with conn.cursor() as cur:
            cur.execute("SELECT NOW();") # PostgreSQL'den şu anki saati iste
            
            
            db_time = cur.fetchone()[0]
            
            return {
                "status": "Basarili",
                "database_time": db_time,
                "message": "Veritabanı bağlantısı harika çalışıyor!"
            }
            
    except Exception as e:
        
        raise HTTPException(
            status_code=500, 
            detail=f"Veritabanı bağlantı hatası: {e}"
        )