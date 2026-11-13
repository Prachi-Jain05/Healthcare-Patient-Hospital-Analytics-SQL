CREATE Database Healthcare;
SELECT COUNT(*)
FROM patients;

SELECT *
FROM patients
LIMIT 10;
SHOW COLUMNS FROM patients;

-- Total Patients 
SELECT COUNT(*) AS Total_Patients
FROM patients;

-- Gender Distribution
SELECT Gender,
       COUNT(*) AS Total
FROM patients
GROUP BY Gender;

-- Blood Group Distribution
SELECT `Blood Type`,
       COUNT(*) AS Total
FROM patients
GROUP BY `Blood Type`
ORDER BY Total DESC;

-- Top Medical Conditions
SELECT `Medical Condition`,
       COUNT(*) AS Total_Patients
FROM patients
GROUP BY `Medical Condition`
ORDER BY Total_Patients DESC;

-- Revenue by Medical Condition
SELECT `Medical Condition`,
       ROUND(SUM(`Billing Amount`),2) AS Revenue
FROM patients
GROUP BY `Medical Condition`
ORDER BY Revenue DESC;

-- Revenue by Hospital
SELECT Hospital,
       ROUND(SUM(`Billing Amount`),2) AS Revenue
FROM patients
GROUP BY Hospital
ORDER BY Revenue DESC
LIMIT 10;

-- Top Doctors by Revenue
SELECT Doctor,
       ROUND(SUM(`Billing Amount`),2) AS Revenue
FROM patients
GROUP BY Doctor
ORDER BY Revenue DESC
LIMIT 10;

-- Patient Risk Categories
SELECT
CASE
WHEN Age < 30 THEN 'Young'
WHEN Age BETWEEN 30 AND 60 THEN 'Adult'
ELSE 'Senior'
END AS Age_Group,
COUNT(*) AS Patients
FROM patients
GROUP BY Age_Group;

-- Top 5 Hospitals by Revenue
SELECT Hospital,
       ROUND(SUM(`Billing Amount`),2) AS Revenue
FROM patients
GROUP BY Hospital
ORDER BY Revenue DESC
LIMIT 5;

-- Average Billing by Admission Type
SELECT `Admission Type`,
       ROUND(AVG(`Billing Amount`),2) AS Avg_Billing
FROM patients
GROUP BY `Admission Type`
ORDER BY Avg_Billing DESC;

-- Test Results Analysis
SELECT `Test Results`,
       COUNT(*) AS Total_Patients
FROM patients
GROUP BY `Test Results`
ORDER BY Total_Patients DESC;

-- Revenue by Insurance Provider
SELECT `Insurance Provider`,
       ROUND(SUM(`Billing Amount`),2) AS Revenue
FROM patients
GROUP BY `Insurance Provider`
ORDER BY Revenue DESC;

-- Window Functions
-- Top 10 Doctors Ranked by Revenue
SELECT Doctor,
       ROUND(SUM(`Billing Amount`),2) AS Revenue,
       RANK() OVER(ORDER BY SUM(`Billing Amount`) DESC) AS Doctor_Rank
FROM patients
GROUP BY Doctor;
-- Top 10 Hospitals Ranked by Revenue
SELECT Hospital,
       ROUND(SUM(`Billing Amount`),2) AS Revenue,
       DENSE_RANK() OVER(
           ORDER BY SUM(`Billing Amount`) DESC
       ) AS Hospital_Rank
FROM patients
GROUP BY Hospital;

-- CASE WHEN
-- Hospital mein kis age group ke sabse zyada patients hain?
SELECT
    CASE
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS Age_Group,
    COUNT(*) AS Total_Patients
FROM patients
GROUP BY Age_Group
ORDER BY Total_Patients DESC;

-- CASE WHEN + Revenue
-- Kaunsa age group sabse zyada revenue generate karta hai?
SELECT
    CASE
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS Age_Group,
    ROUND(SUM(`Billing Amount`),2) AS Revenue
FROM patients
GROUP BY Age_Group
ORDER BY Revenue DESC;

-- Subquery
-- Average bill se zyada bill wale patients kaun hain?
SELECT
    Name, Age,
    `Medical Condition`,
    `Billing Amount`
FROM patients
WHERE `Billing Amount` >
(SELECT AVG(`Billing Amount`)
    FROM patients);
    
-- Subquery + Top Hospitals
-- Average hospital revenue se zyada revenue wale hospitals kaunse hain?
SELECT Hospital,
       ROUND(SUM(`Billing Amount`),2) AS Revenue
FROM patients
GROUP BY Hospital
HAVING Revenue >
(SELECT AVG(Hospital_Revenue)
    FROM (SELECT SUM(`Billing Amount`) AS Hospital_Revenue
        FROM patients
        GROUP BY Hospital) t);
        
-- DENSE_RANK()
-- Top hospitals by revenue
SELECT
    Hospital,
    ROUND(SUM(`Billing Amount`),2) AS Revenue,
    DENSE_RANK() OVER(
        ORDER BY SUM(`Billing Amount`) DESC) AS Hospital_Rank
FROM patients
GROUP BY Hospital;
