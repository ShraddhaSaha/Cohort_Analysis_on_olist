📊 Cohort Analysis using SQL – Olist E-Commerce Dataset
📌 Project Overview

This project performs a customer retention cohort analysis on the Olist Brazilian e-commerce dataset using SQL. The goal is to move beyond aggregate metrics and understand how customer behavior evolves after their first purchase.

Customers are grouped into cohorts based on their first delivered order month, and retention is tracked month-by-month using SQL views and window functions. The final output is visualized as a cohort retention heatmap to highlight churn and retention patterns over time.

🎯 Business Objective

E-commerce businesses often focus heavily on customer acquisition, but long-term growth depends on retention.

This analysis answers key business questions:

How many customers return after their first purchase?

When does the highest churn occur?

Are newer cohorts behaving differently from older ones?

🧩 Dataset

Source: Olist Brazilian E-Commerce Dataset (Kaggle)

Data Type: Real-world transactional e-commerce data

Time Period: 2016–2018

Key tables used:

customers

orders

Only Delivered orders were considered to ensure valid customer activity.

🛠️ Tools & Technologies

SQL (MySQL) – data transformation & analysis

Window Functions – retention calculation

Views – modular and reusable logic

Power BI – cohort heatmap visualization

🔍 Methodology
1️⃣ Cohort Identification

Each customer is assigned a cohort based on the month of their first delivered purchase.

MIN(DATE_FORMAT(order_purchase_timestamp, '%Y-%m')) AS cohort_month
2️⃣ Order Month Mapping

All subsequent delivered orders are mapped to their respective order months.

3️⃣ Cohort Index Calculation

The number of months between the cohort month and each order month is calculated using:

TIMESTAMPDIFF(MONTH, cohort_month, order_month)

This defines the cohort index (Month 0, Month 1, Month 2, ...).

4️⃣ Retention Calculation (Window Function)

Retention is calculated as the percentage of active customers in each cohort relative to the original cohort size.

FIRST_VALUE(active_customers) OVER (PARTITION BY cohort_month ORDER BY cohort_index)

This approach avoids subqueries and improves scalability.

📈 Visualization

A cohort retention heatmap was created to visualize:

Retention decay over time

Differences across cohorts

Critical churn points

Rows represent cohort months, columns represent months since first purchase, and values represent retention percentage.

💡 Key Insights

Significant churn occurs immediately after the first purchase (Month 1)

Retention drops sharply across almost all cohorts

Later cohorts show slight early-retention improvements

Acquisition is strong, but early lifecycle retention is the biggest challenge

📌 Business Recommendations

Focus on improving first-to-second purchase conversion

Introduce post-purchase engagement campaigns within 30 days

Track Month-1 retention as a core KPI

Shift part of acquisition budget toward retention initiatives
