# retail360 — Retail Performance Analytics

## Executive Summary
This project started as a raw retail dataset with no structure, no clarity, and no immediate business value. I built a complete analytics pipeline around it — staging the data, cleaning it, exploring it, and engineering new features — before turning everything into a set of Tableau dashboards that explain how the business performs across products, customers, and transactions. The goal wasn’t just to visualise data, but to understand the story behind it and present it in a way that a business could act on.

## Business Problem
The dataset didn’t come ready for analysis. It had inconsistencies, missing values, unclear relationships, and no engineered fields to support deeper insights.
On top of that, the business questions weren’t defined — so I had to shape them myself:

- What drives revenue and profit in this dataset?
- Which products and suppliers perform well (or poorly)?
- How do customers behave over time — especially repeat customers?
- Are there seasonal or geographic patterns worth paying attention to?
- This project was built to answer those questions using a structured, analyst‑style workflow.

## Methodology
I structured the project into four stages:

### 1. Data Staging
I loaded the raw tables, set up the structure, and made sure the dataset was ready for proper cleaning. This step was about getting everything into a usable state.

### 2. Data Cleaning
This is where most of the heavy lifting happened. I fixed data types, handled missing values, removed duplicates, and made sure fields like dates, quantities, and profit values were consistent. The goal was simple: make the data trustworthy.

### 3. Exploratory Data Analysis (EDA)
Before transforming anything, I explored the dataset to understand what mattered. I looked at revenue patterns, product behaviour, customer activity, returns, and seasonality. This helped me decide which engineered features would actually add value.

### 4. Data Transformation
I created the fields that Tableau would rely on — things like repeat‑customer flags, purchase frequency, seasonal categories, profitability indicators, and return‑rate logic. These features turned the dataset from “raw information” into something that could answer real business questions.

## Results & Business Recommendations
Once the dashboards were built, several patterns became clear:

- Some products generated strong revenue but weak profit, showing margin issues
- Certain suppliers had noticeably higher return rates
- Repeat customers contributed a meaningful share of revenue
- Seasonal patterns were visible across both product demand and customer activity
- Some cities performed well in volume but poorly in profitability

Based on these findings, I would recommend:

- Reviewing low‑margin product categories
- Investigating suppliers with high return rates
- Strengthening retention strategies for low‑frequency customers
- Aligning inventory and marketing with seasonal demand
- Focusing on improving profitability in high‑volume, low‑margin regions

## Next Steps
If I were to continue this project, I’d expand it in a few ways:

- Build a churn prediction model using the engineered customer features
- Automate the SQL pipeline so the dashboards refresh on schedule
- Add cohort analysis to understand long‑term customer behaviour
- Bring in marketing or operational data for deeper context
- Explore forecasting models for demand and revenue

