USE healthcare;

CREATE TABLE patients_clean AS
SELECT DISTINCT
    TRIM(Name)                                   AS Name,
    Age,
    CASE WHEN Age < 30 THEN 'Young'
         WHEN Age <= 60 THEN 'Adult'
         ELSE 'Senior' END                       AS Age_Group,
    Gender,
    `Blood Type`,
    `Medical Condition`,
    STR_TO_DATE(`Date of Admission`, '%Y-%m-%d') AS Admission_Date,
STR_TO_DATE(`Discharge Date`,    '%Y-%m-%d') AS Discharge_Date,
DATEDIFF(STR_TO_DATE(`Discharge Date`, '%Y-%m-%d'),
         STR_TO_DATE(`Date of Admission`, '%Y-%m-%d')) AS Length_of_Stay,
    TRIM(Doctor)                                 AS Doctor,
    TRIM(TRAILING ',' FROM TRIM(Hospital))       AS Hospital,
    `Insurance Provider`,
    ROUND(`Billing Amount`, 2)                   AS Billing_Amount,
    `Room Number`,
    `Admission Type`,
    Medication,
    `Test Results`
FROM patients
WHERE `Billing Amount` > 0;

-- Check karein
SELECT COUNT(*) AS total_rows FROM patients_clean;

USE healthcare;
DESCRIBE patients_clean;

ALTER TABLE patients_clean
MODIFY Billing_Amount DECIMAL(12,2);

DESCRIBE patients_clean;

SELECT
    COUNT(*)                      AS total_rows,
    MIN(Billing_Amount)           AS min_billing,
    MAX(Billing_Amount)           AS max_billing,
    ROUND(AVG(Billing_Amount), 2) AS avg_billing
FROM patients_clean;

SELECT * FROM patients_clean LIMIT 5;

SELECT ROUND(SUM(Billing_Amount), 2) AS total_revenue
FROM patients_clean;