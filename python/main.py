from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

from analytics import (
    get_total_delivered_revenue,
    get_delivered_order_count,
    get_revenue_by_category,
)

from ai_assistant import ask_ai


app = FastAPI(
    title="AI E-Commerce Analytics API",
    description="API for e-commerce business KPIs and AI insights",
    version="1.0.0",
)


class QuestionRequest(BaseModel):
    question: str = Field(
        min_length=3,
        max_length=1000,
        description="Your e-commerce business question",
    )


@app.get("/")
def home():
    return {
        "message": "AI E-Commerce Analytics API is running"
    }


@app.get("/kpis/summary")
def get_kpi_summary():
    try:
        revenue = get_total_delivered_revenue()
        order_count = get_delivered_order_count()

        return {
            "total_delivered_revenue_brl": float(revenue or 0),
            "delivered_order_count": order_count,
        }

    except Exception as error:
        raise HTTPException(
            status_code=500,
            detail="Unable to retrieve KPI summary",
        ) from error


@app.get("/kpis/categories")
def get_category_kpis():
    try:
        rows = get_revenue_by_category()

        return {
            "categories": [
                {
                    "category": category,
                    "revenue_brl": float(revenue or 0),
                }
                for category, revenue in rows
            ]
        }

    except Exception as error:
        raise HTTPException(
            status_code=500,
            detail="Unable to retrieve category KPIs",
        ) from error


@app.post("/ai/ask")
def ask_business_question(request: QuestionRequest):
    try:
        return ask_ai(request.question.strip())

    except RuntimeError as error:
        raise HTTPException(
            status_code=502,
            detail=str(error),
        ) from error

    except Exception as error:
        raise HTTPException(
            status_code=500,
            detail="Unable to process the AI question",
        ) from error