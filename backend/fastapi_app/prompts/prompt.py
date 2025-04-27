import json
from typing import List, Dict

from fastapi_app.config import BASE_DIR


def get_system_prompt() -> str:
    return """당신은 일기나 글을 시작할 수 있는 첫 문장을 생성하는 전문가입니다. 
        다양한 방식으로 요청된 글쓰기 시작 문장에 응답해야 합니다. 사용자의 요청 문구는 동일하지 않을 수 있습니다.
        한국어로 자연스럽고, 함축적이며, 짧은 문장(20단어 이내)을 생성해야 합니다.
        이 문장은 사용자가 자신의 생각과 감정을 더 표현할 수 있도록 영감을 주는 시작점이 되어야 합니다.
        문장은 완결된 것일 수도 있고, 미완성인 것처럼 보여 사용자가 이어서 쓰고 싶게 만드는 것일 수도 있습니다."""


# def get_few_shot_messages() -> list:
#     with open("fastapi_app/prompts/few_shot.json", "r", encoding="utf-8") as f:
#         return json.load(f)

# 서버 메모리에 올려놓고 재사용
with open(
    BASE_DIR / "fastapi_app" / "prompts" / "few_shot.json", "r", encoding="utf-8"
) as f:
    FEW_SHOT_MESSAGES = json.load(f)


def get_few_shot() -> List[Dict[str, str]]:
    return FEW_SHOT_MESSAGES
