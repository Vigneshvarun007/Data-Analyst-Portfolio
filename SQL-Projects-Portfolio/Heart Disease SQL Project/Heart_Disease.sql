create database heart_disease;
use heart_disease;
select * from disease;

-- 1. Total Patients and Disease Rate--
SELECT 
  COUNT(*) AS total_patients,
  SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END) AS disease_cases,
  ROUND(100.0 * SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS disease_rate_percent
FROM disease;

-- 2. Age Group Risk Segmentation--
SELECT CASE 
    WHEN age < 40 THEN '< 40'
    WHEN age BETWEEN 40 AND 55 THEN '40-55'
    WHEN age BETWEEN 56 AND 70 THEN '56-70'
    ELSE '> 70'
  END AS age_group, COUNT(*) AS total,
  SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END) AS disease_cases,
  ROUND(100.0 * SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS disease_rate
FROM disease GROUP BY age_group ORDER BY age_group;

-- 3. Gender-Based Risk --
SELECT sex, COUNT(*) AS total,
SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END) AS disease_cases,
ROUND(100.0 * SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS disease_rate
FROM disease GROUP BY sex;

-- 4. Chest Pain Type vs Heart Disease --
SELECT chest_pain_type, COUNT(*) AS total_patients,
SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END) AS disease_cases,
ROUND(100.0 * SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS risk_rate
FROM disease GROUP BY chest_pain_type ORDER BY risk_rate DESC;

-- 5. Blood Pressure & Cholestrol Risk--
-- Patients with high BP > 140 and cholesterol > 240 who have heart disease--
SELECT patient_id, resting_blood_pressure, serum_cholesterol_mg_per_dl
FROM disease WHERE heart_disease_present = 1 AND resting_blood_pressure > 140 AND serum_cholesterol_mg_per_dl > 240;

-- 6. Fasting Sugar Impact--
SELECT fasting_blood_sugar_gt_120_mg_per_dl AS high_fbs,COUNT(*) AS total_patients,
SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END) AS disease_cases, 
ROUND(100.0 * SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS disease_rate FROM disease
GROUP BY high_fbs;

-- 7. Thalassemia vs Disease Rate--
SELECT thal, COUNT(*) AS total_patients, SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END) AS disease_cases,
ROUND(100.0 * SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS risk_rate
FROM disease GROUP BY thal;

-- 8. Exercise-Induced Angina Analysis--
SELECT exercise_induced_angina,
COUNT(*) AS total, SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END) AS disease_cases,
ROUND(100.0 * SUM(CASE WHEN heart_disease_present = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS risk_percent
FROM disease GROUP BY exercise_induced_angina;

-- 9. Risk Score Calculation--
-- Risk score = bp + cholesterol + oldpeak * 10--

SELECT patient_id, resting_blood_pressure, serum_cholesterol_mg_per_dl,oldpeak_eq_st_depression,
(resting_blood_pressure + serum_cholesterol_mg_per_dl + (oldpeak_eq_st_depression * 10)) AS risk_score
FROM disease ORDER BY risk_score DESC LIMIT 10;

-- 10. Window Function - Rank Patients by Max Heart Rate--
SELECT patient_id,age,max_heart_rate_achieved,
RANK() OVER (ORDER BY max_heart_rate_achieved DESC) AS heart_rate_rank
FROM disease LIMIT 10;


