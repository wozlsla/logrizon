from fastapi import HTTPException
import openai
from fastapi_app.config import OPENAI_API_KEY
from .prompts.prompt import get_system_prompt, get_few_shot


openai.api_key = OPENAI_API_KEY

client = openai.AsyncClient()


async def generate_sentence():
    try:
        system_prompt = get_system_prompt()
        few_shot = get_few_shot()

        messages = [{"role": "system", "content": system_prompt}] + few_shot
        # messages = [{"role": "system", "content": "세글자를 랜덤으로 대답해"}]

        response = await client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            max_tokens=30,
            temperature=1.0,
            top_p=0.9,
            frequency_penalty=0.5,
            presence_penalty=0.5,
        )
        # print(f"응답: {response}")

        return response.choices[0].message.content

    except openai.error.AuthenticationError:
        raise HTTPException(status_code=401, detail="Invalid OpenAI API Key.")
    except openai.error.RateLimitError:
        raise HTTPException(status_code=429, detail="OpenAI API rate limit exceeded.")
    except openai.error.APIConnectionError:
        raise HTTPException(
            status_code=502, detail="Failed to connect to OpenAI server."
        )
    except openai.error.InvalidRequestError as e:
        raise HTTPException(status_code=400, detail=f"Invalid request: {str(e)}")
    except openai.error.OpenAIError as e:
        raise HTTPException(status_code=500, detail=f"OpenAI API error: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {str(e)}")
