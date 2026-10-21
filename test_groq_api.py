import json
import os
import urllib.request
import urllib.error

from dotenv import load_dotenv

load_dotenv()

api_key = os.getenv("GROQ_API_KEY")

if not api_key:
    print("GROQ_API_KEY was not found in .env")
    raise SystemExit(1)

url = "https://api.groq.com/openai/v1/chat/completions"

payload = {
    "model": "openai/gpt-oss-120b",
    "messages": [
        {
            "role": "user",
            "content": "Reply with exactly: Groq API test successful."
        }
    ],
    "temperature": 0,
    "max_completion_tokens": 50,
}

request = urllib.request.Request(
    url,
    data=json.dumps(payload).encode("utf-8"),
    headers={
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "User-Agent": "AI-Ecommerce-Analytics/1.0",
    },
    method="POST",
)

try:
    with urllib.request.urlopen(request, timeout=30) as response:
        result = json.loads(response.read().decode("utf-8"))

    answer = result["choices"][0]["message"]["content"]
    print("API connection successful.")
    print("Model response:", answer)

except urllib.error.HTTPError as error:
    print("Groq API returned HTTP status:", error.code)
    print("Check the API key, model access, rate limits, or provider status.")

except Exception as error:
    print("Request failed:", type(error).__name__, str(error))