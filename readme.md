# 📉 Telco Customer Churn Analysis – SQL + Power BI Business Insights

## 🔍 Problem
Customer churn is a silent killer in subscription-based businesses like telecom.  
This project analyzes over 7,000 customer records using SQL to uncover the root causes of churn and presents the insights in an interactive Power BI dashboard. The goal: drive data-backed retention strategies to prevent millions in potential revenue loss.

---

## 📊 Dataset Overview

- Source: [IBM Telco Customer Churn – Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
- Records: 7,043 customers
- Features: 21 (tenure, contract type, billing, payment method, internet service, etc.)
- Format: CSV → PostgreSQL → Power BI

---

## 🚀 How to Reproduce

1. Install PostgreSQL 15+
2. Run the scripts:
   ```bash
   psql -f sql/create_table.sql
   psql -f sql/data_insertion.sql
   psql -f sql/analysis_queries.sql

---

## 💡 Key Business Insights (SQL-Driven)

| Insight | Impact |
|--------|--------|
| 🧾 Paperless + Month-to-Month users churn at 48% | ~₹1.6M in monthly revenue loss — high-risk segment |
| 💳 Electronic Check users churn at 45% | Push toward AutoPay to reduce churn |
| 🕐 First-Year customers churn at 50% | Onboarding + retention journey needed early |
| 📄 2-Year contract users churn at just 1–4% | Longer commitment drastically improves retention |
| 📡 Fiber + No Tech Support = high churn | Indicates poor service experience or product friction |

---

## 🧠 Churn Score Model (in SQL)

A custom SQL scoring model ranks each customer:

| Rule                                  | Points |
|---------------------------------------|--------|
| Month-to-Month contract               | +2     |
| Tenure < 6 months                     | +2     |
| TechSupport = "No"                    | +1     |
| PaymentMethod = "Electronic check"    | +1     |

| Score | Risk Level | Observed Churn |
|-------|------------|----------------|
| 5–6   | High       | 64%            |
| 3–4   | Medium     | 28%            |
| 0–2   | Low        | 9%             |

This score was computed using SQL logic inside a CASE-based formula and used to create risk segments and target high-priority customers in the dashboard.

---

## 📌 Business Recommendations

1. Convert month-to-month paperless users to annual plans with loyalty offers  
2. Incentivize AutoPay for electronic check users to cut churn in half  
3. Launch onboarding workflows for first 90 days to improve early retention  
4. Bundle Tech Support with fiber plans to improve product satisfaction  

---

## 📈 Dashboard Preview

![Dashboard](reports/churn_dashboard_final.png)

Includes:

- KPI cards: Total Customers (7,043) · Total Charges (₹16.06M)
- Donut + Bar charts: Churn by Contract, Payment, Internet Service
- Tenure-based churn insights
- Embedded Insight Summary Box

---

## 📁 Project Structure
/sql/
├── create_table.sql            ← Table + indexes
├── data_insertion.sql          ← \COPY from CSV
└── Query_analysis.sql        ← Churn, revenue loss, churn score, etc.

/data/
└── WA_Fn-UseC_-Telco-Customer-Churn.csv  ← Dataset (or download instruction)

/reports/
├── churn_kpi_dashboard.pbix    ← Final Power BI file
├── churn_dashboard_final.png   ← Dashboard image preview
└── sql_outputs/                ← .txt logs for transparency
    ├── churn_by_contract.txt
    ├── churn_score_distribution.txt
    └── revenue_lost_by_segment.txt

---

## 🧰 Tools Used

- PostgreSQL 15 – data storage and analysis  
- Power BI Desktop – visual storytelling  
- SQL only – no Python or Jupyter dependencies

---

## 📄 License

This project is licensed under the MIT License.  
See [License](LICENSE) for details.

---

## 👤 Author

Created by [Tarun Lakhani](https://github.com/tar1536)  
📬 [Connect on LinkedIn](https://www.linkedin.com/in/tarun-lakhani-4b6a93235/)
