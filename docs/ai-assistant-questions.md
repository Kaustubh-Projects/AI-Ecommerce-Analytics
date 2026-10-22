# AI Assistant - User Question Guide

## 1. Purpose

This guide explains what users can ask the AI assistant in the AI-Powered E-Commerce Analytics Platform.

The assistant uses a generative AI model through the Groq API. It receives a business question and a predefined set of business metrics retrieved by the application from PostgreSQL.

**Important:** The assistant can only give evidence-based answers when the supplied business context contains the information needed to answer the question. A fluent answer is not automatically a verified answer.

## 2. How to Access the Assistant

1. Start the FastAPI application from the project root.
2. Open `http://127.0.0.1:8000/docs` in your browser.
3. Find `POST /ai/ask`.
4. Select **Try it out**.
5. Enter a question in the request body.
6. Select **Execute** and review the response.

Example request:

```json
{
  "question": "What is the total delivered revenue, and how many delivered orders do we have?"
}
```

## 3. Questions Supported by the Current Business Context

The current assistant retrieves total delivered revenue, delivered order count, and the five highest-revenue product categories.

### 3.1 Business KPIs

Example questions:

- What is the total delivered revenue?
- How many delivered orders do we have?
- What is our total delivered revenue and delivered order count?
- Summarize the main business figures available in your data.

These questions can be answered using the current business context.

### 3.2 Product Category Revenue

Example questions:

- Which product category has the highest revenue among the five categories provided?
- What are the top five product categories by revenue?
- Compare the revenue figures of the five highest-revenue categories.
- Which category should we examine first based on the revenue figures?

The assistant can summarize and compare the supplied category figures. Recommendations should be treated as suggestions based on those figures, not proof of why a category performs well.

### 3.3 Business Recommendations Based on Available Metrics

Example questions:

- What business recommendations would you make based on these category revenue figures?
- Which of the five categories should we investigate for possible cross-selling opportunities?
- What additional KPIs should we monitor before increasing marketing investment?
- What additional data would help us understand category performance?

The assistant can generate recommendations and identify useful follow-up analyses. These are not verified causes or guaranteed business outcomes.

## 4. Questions Requiring Additional Data or Analysis

The following questions are not fully supported by the current assistant context.

| Example question | What is additionally required |
|---|---|
| What is the highest-selling individual product? | Product-level units sold or revenue, ranked using a clearly defined metric |
| Which seller generated the most revenue? | Seller-level revenue results |
| Which month had the highest revenue? | Monthly revenue aggregation |
| Why did revenue decline in a particular month? | Period-specific revenue data and additional evidence to investigate possible causes |
| Which customers are at risk of becoming inactive? | Relevant model predictions and customer-level results, with appropriate privacy controls |
| What are the most common negative customer reviews? | Review-level sentiment results and a method for summarizing recurring themes |
| What caused delivery delays? | Delivery performance data and additional evidence about potential contributing factors |

Some of these analyses already exist elsewhere in the project. However, the current assistant does not automatically retrieve all those results for every question. Their existence elsewhere in the project does not mean they are currently available to this endpoint.

## 5. Questions That Require Further Investigation

Questions asking why something happened need more than a single metric.

For example:

**Question:** Why did revenue decline in September 2018?

The current context contains overall delivered revenue and category revenue figures, but it does not contain monthly revenue trends. Therefore, the assistant cannot establish whether revenue declined in September 2018 or identify the cause.

A suitable next step would be to retrieve monthly revenue and order counts, compare relevant categories, and investigate additional operational or marketing data if available.

The assistant should distinguish verified facts from hypotheses and acknowledge when the evidence is insufficient.

## 6. Understanding the Response

The API response includes:

- `question`: the submitted question.
- `answer`: the generated natural-language response.
- `business_context`: the metrics supplied to the model.

Use the business context to check important numerical claims. The model's answer should not be treated as an independent database query or a substitute for validating the underlying results.

## 7. Current Limitations

- The assistant retrieves a fixed set of business metrics for each question.
- It does not dynamically select arbitrary SQL queries based on user intent.
- It cannot reliably answer questions requiring data that was not included in the supplied context.
- Recommendations may require further analysis before they can be treated as business decisions.
- Prompt instructions do not eliminate hallucinations.
- The API requires a valid provider key, internet access, and available model capacity.
- The current API has been tested locally; public deployment is not established by this guide.

## 8. Potential Future Enhancements

Possible future improvements include:

- Selecting from a wider set of predefined analytics functions based on the question.
- Adding verified product-level and seller-level rankings to the assistant context.
- Retrieving monthly sales and delivery performance metrics when needed.
- Integrating selected review sentiment results with appropriate privacy safeguards.
- Evaluating generated answers against known SQL results.
- Adding authentication, rate limiting, monitoring, and production deployment controls.

These are future enhancements unless they are separately implemented and verified.

## 9. Important Usage Rule

Ask questions that match the metrics currently supplied to the assistant when you need a direct, evidence-based answer.

For broader questions, review the returned business context and treat recommendations as hypotheses until they are validated with the appropriate data.