from time import sleep
from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse
from .gpt_service import generate_sentence

app = FastAPI()


@app.post("/generate-sentence")
async def generate_sentence_api():
    try:
        sentence = await generate_sentence()
        print(sentence)
        # sleep(5)
        return {"sentence": sentence}
    except Exception as e:
        raise {"error": str(e)}
        # raise HTTPException(status_code=500, detail=str(e))
