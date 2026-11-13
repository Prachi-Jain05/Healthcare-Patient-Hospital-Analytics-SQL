# Healthcare Patient & Hospital Analytics

An end-to-end healthcare data project: data cleaning in MySQL, business analysis with SQL, and an interactive Power BI dashboard.

## Project overview
The dataset contains 55,500 patient records with billing, admission, doctor, hospital and insurance details. The raw data had quality issues (duplicate rows, zero or negative billing, inconsistent name casing, and trailing commas in hospital names). This project cleans the data, answers business questions with SQL, and presents the results in a Power BI dashboard.

## Key results (cleaned data, 54,860 records)
- **Total revenue:** 1.40bn across all records
- **Revenue by condition:** spread evenly across six conditions (about 17% each)
- **Age groups:** Adults make up 46% of patients and 46% of revenue
- **Billing pattern:** average bill is nearly the same across age groups and admission types
- **Hospitals:** the top 10 hospitals contribute only 0.67% of revenue, because there are 39,815 distinct hospital names

## Data cleaning (MySQL)
- Removed 534 exact duplicate rows
- Removed 106 rows with zero or negative billing
- Trimmed spaces and trailing commas, and standardised name and hospital casing
- Converted text dates (dd-mm-yyyy) to DATE type
- Derived `Length_of_Stay` and `Age_Group` columns

Result: 55,500 raw rows became **54,860 clean rows**.

## SQL analysis
The analysis uses GROUP BY, CASE WHEN, subqueries, HAVING, and RANK / DENSE_RANK window functions. It covers:
- Patient counts by gender, blood type, condition and age group
- Revenue by condition, insurer, hospital and doctor
- Average billing and length of stay
- Top 10 hospitals and doctors, with ranking
- Admissions by year

## Power BI dashboard
- **KPI cards:** Total Patients, Total Revenue, Average Length of Stay, Average Billing per Patient
- **Slicers:** Admission Type, Gender, Medical Condition
- **Charts:** Revenue by Medical Condition, Admissions trend, Patients by Age Group (donut), Top 10 Hospitals by Revenue
- **DAX measures:** defined in the model for the KPIs and percentages


## How to run
1. Import `data/healthcare_dataset.csv` into MySQL as the `patients` table, in the `healthcare` database.
2. Run `sql/01_cleaning.sql` to create the `patients_clean` table.
3. Run `sql/02_analysis.sql` to reproduce the analysis and the dashboard numbers.
4. Open `powerbi/Healthcare_Dashboard.pbix` in Power BI Desktop. If the data source is not found, update it to your local MySQL connection.

## Tools
MySQL 8 · Power BI Desktop · DAX · Power Query · Excel

## Limitations
The dataset is very uniform (gender, blood type and billing are nearly evenly distributed), which is unusual for real hospital data. The findings describe this dataset only and should not be read as clinical or operational conclusions.


## 👩‍💻 Built By
**Prachi Jain** — Data Analyst
[LinkedIn](https://linkedin.com/in/prachi-jain-524a95251) · [GitHub](https://github.com/Prachi-Jain05)
