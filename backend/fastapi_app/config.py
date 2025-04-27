import os
from pathlib import Path
from dotenv import load_dotenv
import openai

# 프로젝트 최상단 경로 (일단, django랑 분리)
BASE_DIR = Path(__file__).resolve().parent.parent

load_dotenv(BASE_DIR / ".env")


OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# 서버 실행 시 확인 (dev)
if not OPENAI_API_KEY:
    raise RuntimeError("OPENAI_API_KEY 없음")
