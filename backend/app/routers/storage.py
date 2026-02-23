import os
from fastapi import APIRouter, File, Form, UploadFile

router = APIRouter()

STORAGE_ROOT = "/app/storage"


@router.post("/upload")
async def upload_file(
    bucket: str = Form(...),
    file: UploadFile = File(...),
):
    os.makedirs(os.path.join(STORAGE_ROOT, bucket), exist_ok=True)
    file_path = os.path.join(STORAGE_ROOT, bucket, file.filename)
    content = await file.read()
    with open(file_path, "wb") as f:
        f.write(content)
    return {"url": f"/storage/{bucket}/{file.filename}"}
