create database telecom_churn;
use telecom_churn;
select * from no_churn;
desc no_churn;

-- 1. Basic KPIs --

-- Total No of Customers--
select count(*)as No_of_Customers from no_churn;
-- Total churned customers--
SELECT COUNT(*) as No_Churned_Customers FROM no_churn WHERE TRIM(Churn) = 'FALSE';
-- Churn Rate--
select round(100.0*sum(case when trim(Churn) = 'TRUE' then 1 else 0 end)/ count(*),2) as Churn_Rate from no_churn;


-- 2. State-Wise Churn Analysis--
select State, count(*) as Total_Customers, sum(case when trim(Churn) = 'TRUE' then 1 else 0 end) as Churned_Customers,
round(100.0*sum(case when trim(Churn)= 'TRUE' then 1 else 0 end)/ count(*),2)as Churn_Rate from no_churn group by State order by Churn_Rate desc;

-- 3. Plan-Based Churn Analysis--

-- Churn by International_Plan--

select International_Plan, count(*) as Total_Customers, sum(case when trim(Churn) = 'TRUE' then 1 else 0 end) as Churned_Customers, 
round(100.0*sum(case when trim(Churn) = 'TRUE' then 1 else 0 end)/ count(*),2) as Churn_Rate from no_churn group by International_Plan;

-- Churn by VoiceMail_Plan--
select Vmail_Plan, count(*) as Total_Customers, sum(case when churn = 'True' then 1 else 0 end) as Churned_Customers,
round(100.0*sum(case when churn = 'TRUE' then 1 else 0 end)/ count(*),2) as Churn_Rate from no_churn group by Vmail_Plan;

-- 4. Customer Service Call Impact --

SELECT CustServ_Calls, COUNT(*) AS Total_Customers, SUM(CASE WHEN Churn = 'True' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(100.0 * SUM(CASE WHEN Churn = 'True' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM no_churn GROUP BY CustServ_Calls ORDER BY CustServ_Calls;

-- 5. Usage Pattern Analysis --

select churn, round(avg(Day_Mins),2) as Avg_Day_Mins,
round(avg(Eve_Mins),2) as Avg_Eve_Mins,
round(avg(Night_Mins),2)as Avg_Night_Mins,
round(avg(International_Plan),2) as Avg_International_Plan from no_churn group by churn;

-- 6. High Risk Customer Segment--

SELECT Phone, State, International_Mins, CustServ_Calls, VMail_Plan
FROM no_churn WHERE Churn = 'TRUE' AND International_Mins > 8
AND CustServ_Calls > 3 AND VMail_Plan = 'no';

-- 7. Tenure-Based segmentation --
SELECT CASE WHEN Account_Length <= 50 THEN '0–50 days'
WHEN Account_Length BETWEEN 51 AND 100 THEN '51–100 days'
ELSE '100+ days' END AS tenure_group, COUNT(*) AS total_customers,
SUM(CASE WHEN Churn = 'True' THEN 1 ELSE 0 END) AS churned, ROUND(100.0 * SUM(CASE WHEN Churn = 'True' THEN 1 ELSE 0 END)/COUNT(*), 2) AS churn_rate
FROM no_churn GROUP BY tenure_group;

SELECT Phone,(Day_Charge + Eve_Charge + Night_Charge + International_Charge) AS Total_Charges,
RANK() OVER (ORDER BY (Day_Charge + Eve_Charge + Night_Charge + International_Charge) DESC) AS Charge_Rank
FROM no_churn;

