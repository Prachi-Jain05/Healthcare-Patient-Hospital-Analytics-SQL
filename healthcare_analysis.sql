-- ============================================================
-- Healthcare Patient & Hospital Analytics
-- Business questions answered on the CLEANED table: patients_clean
-- ============================================================

USE healthcare;

-- ------------------------------------------------------------
-- 0. Basic checks
-- ------------------------------------------------------------
SELECT COUNT(*) AS Total_Rows FROM patients_clean;           

SELECT * FROM patients_clean LIMIT 10;

SHOW COLUMNS FROM patients_clean;

-- ------------------------------------------------------------
-- 1. Total patients
-- ------------------------------------------------------------
SELECT COUNT(*) AS Total_Patients
FROM patients_clean;

-- ------------------------------------------------------------
-- 2. Gender distribution (GROUP BY)
-- ------------------------------------------------------------
SELECT Gender,
       COUNT(*) AS Total
FROM patients_clean
GROUP BY Gender;

-- ------------------------------------------------------------
-- 3. Blood type distribution
-- ------------------------------------------------------------
SELECT `Blood Type`,
       COUNT(*) AS Total
FROM patients_clean
GROUP BY `Blood Type`
ORDER BY Total DESC;

-- ------------------------------------------------------------
-- 4. Patients by medical condition
-- ------------------------------------------------------------
SELECT `Medical Condition`,
       COUNT(*) AS Total_Patients
FROM patients_clean
GROUP BY `Medical Condition`
ORDER BY Total_Patients DESC;

-- ------------------------------------------------------------
-- 5. Revenue by medical condition
-- ------------------------------------------------------------
SELECT `Medical Condition`,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
GROUP BY `Medical Condition`
ORDER BY Revenue DESC;

-- ------------------------------------------------------------
-- 6. Revenue by insurance provider
-- ------------------------------------------------------------
SELECT `Insurance Provider`,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
GROUP BY `Insurance Provider`
ORDER BY Revenue DESC;

-- ------------------------------------------------------------
-- 7. Average billing by admission type
-- ------------------------------------------------------------
SELECT `Admission Type`,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing
FROM patients_clean
GROUP BY `Admission Type`
ORDER BY Avg_Billing DESC;

-- ------------------------------------------------------------
-- 8. Test results distribution
-- ------------------------------------------------------------
SELECT `Test Results`,
       COUNT(*) AS Total_Patients
FROM patients_clean
GROUP BY `Test Results`
ORDER BY Total_Patients DESC;

-- ------------------------------------------------------------
-- 9. Abnormal test percentage by medical condition
-- ------------------------------------------------------------
SELECT `Medical Condition`,
       ROUND(100 * SUM(`Test Results` = 'Abnormal') / COUNT(*), 2) AS Abnormal_Pct
FROM patients_clean
GROUP BY `Medical Condition`
ORDER BY Abnormal_Pct DESC;

-- ------------------------------------------------------------
-- 10. Average length of stay by medical condition
-- ------------------------------------------------------------
SELECT `Medical Condition`,
       ROUND(AVG(Length_of_Stay), 2) AS Avg_Length_of_Stay
FROM patients_clean
GROUP BY `Medical Condition`
ORDER BY Avg_Length_of_Stay DESC;

-- ------------------------------------------------------------
-- 11. Patients by age group (CASE WHEN)
-- ------------------------------------------------------------
SELECT Age_Group,
       COUNT(*) AS Total_Patients
FROM patients_clean
GROUP BY Age_Group
ORDER BY Total_Patients DESC;

-- ------------------------------------------------------------
-- 12. Revenue by age group (CASE WHEN + SUM)
-- ------------------------------------------------------------
SELECT Age_Group,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
GROUP BY Age_Group
ORDER BY Revenue DESC;

-- ------------------------------------------------------------
-- 13. Admissions by year (trend)
-- ------------------------------------------------------------
SELECT YEAR(Admission_Date) AS Admission_Year,
       COUNT(*) AS Admissions
FROM patients_clean
GROUP BY Admission_Year
ORDER BY Admission_Year;

-- ------------------------------------------------------------
-- 14. Top 10 hospitals by revenue
-- ------------------------------------------------------------
SELECT Hospital,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
GROUP BY Hospital
ORDER BY Revenue DESC
LIMIT 10;

-- ------------------------------------------------------------
-- 15. Top 10 doctors by revenue
-- ------------------------------------------------------------
SELECT Doctor,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
GROUP BY Doctor
ORDER BY Revenue DESC
LIMIT 10;

-- ------------------------------------------------------------
-- 16. Top 10 doctors ranked (RANK window function)
-- ------------------------------------------------------------
SELECT Doctor,
       ROUND(SUM(Billing_Amount), 2) AS Revenue,
       RANK() OVER (ORDER BY SUM(Billing_Amount) DESC) AS Doctor_Rank
FROM patients_clean
GROUP BY Doctor
ORDER BY Doctor_Rank
LIMIT 10;

-- ------------------------------------------------------------
-- 17. Top 10 hospitals ranked (DENSE_RANK window function)
-- ------------------------------------------------------------
SELECT Hospital,
       ROUND(SUM(Billing_Amount), 2) AS Revenue,
       DENSE_RANK() OVER (ORDER BY SUM(Billing_Amount) DESC) AS Hospital_Rank
FROM patients_clean
GROUP BY Hospital
ORDER BY Hospital_Rank
LIMIT 10;

-- ------------------------------------------------------------
-- 18. Patients with bill above the average bill (subquery)
-- ------------------------------------------------------------
SELECT Name,
       Age,
       `Medical Condition`,
       Billing_Amount
FROM patients_clean
WHERE Billing_Amount > (SELECT AVG(Billing_Amount) FROM patients_clean);

-- ------------------------------------------------------------
-- 19. Hospitals with revenue above average hospital revenue
--     (subquery inside HAVING)
-- ------------------------------------------------------------
SELECT Hospital,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
GROUP BY Hospital
HAVING SUM(Billing_Amount) > (
    SELECT AVG(h.Hospital_Revenue)
    FROM (
        SELECT SUM(Billing_Amount) AS Hospital_Revenue
        FROM patients_clean
        GROUP BY Hospital
    ) AS h
)
ORDER BY Revenue DESC;

-- ============================================================
-- DASHBOARD REPLICATION
-- Each query below matches one visual on the Power BI dashboard.
-- ============================================================

-- ------------------------------------------------------------
-- KPI 1: Total Patients (card)
-- ------------------------------------------------------------
SELECT COUNT(*) AS Total_Patients
FROM patients_clean;

-- ------------------------------------------------------------
-- KPI 2: Total Revenue (card)
-- ------------------------------------------------------------
SELECT ROUND(SUM(Billing_Amount), 2) AS Total_Revenue
FROM patients_clean;

-- ------------------------------------------------------------
-- KPI 3: Average Length of Stay (card)
-- ------------------------------------------------------------
SELECT ROUND(AVG(Length_of_Stay), 2) AS Avg_Length_of_Stay
FROM patients_clean;

-- ------------------------------------------------------------
-- KPI 4: Average Billing per Patient (card)
-- ------------------------------------------------------------
SELECT ROUND(AVG(Billing_Amount), 2) AS Avg_Billing_per_Patient
FROM patients_clean;

-- ALL 4 KPIs IN ONE ROW (useful for checking against the dashboard)
SELECT COUNT(*)                        AS Total_Patients,
       ROUND(SUM(Billing_Amount), 2)   AS Total_Revenue,
       ROUND(AVG(Length_of_Stay), 2)   AS Avg_Length_of_Stay,
       ROUND(AVG(Billing_Amount), 2)   AS Avg_Billing_per_Patient
FROM patients_clean;

-- ------------------------------------------------------------
-- VISUAL: Revenue by Medical Condition (bar chart)
-- ------------------------------------------------------------
SELECT `Medical Condition`,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
GROUP BY `Medical Condition`
ORDER BY Revenue DESC;

-- ------------------------------------------------------------
-- VISUAL: Admissions by calendar year (line chart)
-- ------------------------------------------------------------
SELECT YEAR(Admission_Date) AS Admission_Year,
       COUNT(*) AS Total_Patients
FROM patients_clean
GROUP BY Admission_Year
ORDER BY Admission_Year;

-- ------------------------------------------------------------
-- VISUAL: Monthly admissions trend (year + month, for a true time series)
-- ------------------------------------------------------------
SELECT DATE_FORMAT(Admission_Date, '%Y-%m') AS Year_Month,
       COUNT(*) AS Total_Patients
FROM patients_clean
GROUP BY Year_Month
ORDER BY Year_Month;

-- ------------------------------------------------------------
-- VISUAL: Patients by Age Group (donut chart) with percentage
-- ------------------------------------------------------------
SELECT Age_Group,
       COUNT(*) AS Total_Patients,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM patients_clean), 2) AS Pct_of_Patients
FROM patients_clean
GROUP BY Age_Group
ORDER BY Total_Patients DESC;

-- ------------------------------------------------------------
-- VISUAL: Top 10 Hospitals by Revenue (bar chart)
-- ------------------------------------------------------------
SELECT Hospital,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
GROUP BY Hospital
ORDER BY Revenue DESC
LIMIT 10;

-- ------------------------------------------------------------
-- SLICERS: Power BI slicers filter the visuals. In SQL, the same
-- effect comes from a WHERE clause. Change the values to test.
-- Example: Admission Type = 'Emergency', Gender = 'Female'
-- ------------------------------------------------------------
SELECT COUNT(*)                      AS Total_Patients,
       ROUND(SUM(Billing_Amount), 2) AS Total_Revenue,
       ROUND(AVG(Length_of_Stay), 2) AS Avg_Length_of_Stay
FROM patients_clean
WHERE `Admission Type` = 'Emergency'
  AND Gender = 'Female';

-- Same slicer logic, grouped by medical condition
SELECT `Medical Condition`,
       COUNT(*)                      AS Patients,
       ROUND(SUM(Billing_Amount), 2) AS Revenue
FROM patients_clean
WHERE `Admission Type` = 'Emergency'
  AND Gender = 'Female'
GROUP BY `Medical Condition`
ORDER BY Revenue DESC;