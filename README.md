# Healthcare Patient & Hospital Analytics (Using SQL)

SQL-based analysis of 55,500 healthcare records — uncovering patient trends, hospital performance, doctor rankings, insurance coverage patterns, and revenue drivers using advanced SQL techniques.

📊 **Query Results:**
([Query Results](query_results.png))

## 🚀 SQL Concepts Used
- GROUP BY
- ORDER BY
- CASE WHEN
- Subqueries
- RANK()
- DENSE_RANK()

## 💼 Business Questions Solved
- Most common medical conditions
- Revenue by hospital
- Revenue by insurance provider
- Doctor performance analysis
- Age group analysis
- Above-average billing analysis

## 📊 Key Insights
- Analyzed 55,500 patient records with a nearly even gender split (Male: 27,774 · Female: 27,726)
- Diabetes generated the highest total revenue (238.5M) among medical conditions — despite Arthritis having the highest patient count, showing revenue isn't purely volume-driven
- Johnson PLC ranked as the top revenue-generating hospital; Michael Smith ranked as the top revenue-generating doctor
- Adult patients (age 30–60) generated the highest total revenue (650.6M) — more than Senior and Young patients combined
- Cigna was the top revenue-contributing insurance provider (287.1M)
- Billing amounts stayed nearly identical across admission types (Elective, Urgent, Emergency) — no single admission type disproportionately drives cost

## 🛠️ Tech Stack
SQL (MySQL)

## ⚙️ How to Run
1. Clone this repository
2. Import `healthcare_dataset.csv` into MySQL
3. Run the queries from `HEALTHCARE_ANALYSIS_SQL.sql` to reproduce the analysis

## 👩‍💻 Built By
**Prachi Jain** — Data Analyst
[LinkedIn](https://linkedin.com/in/prachi-jain-524a95251) · [GitHub](https://github.com/Prachi-Jain05)
