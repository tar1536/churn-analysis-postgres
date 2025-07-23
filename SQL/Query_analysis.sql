-- Gender clasfification but nothing special was found as they were fairly similar.
select gender,
sum(case when Churn='Yes' then MonthlyCharges else 0 end) as money_lost
from telecom_churn
group by gender;

-- Gave a first clear and major insight where the most churna are happenning in month-to-month users

select MultipleLines, count(*), Contract,
round(100*sum( case when Churn='Yes' then 1 else 0 end)/count(*),2)
from telecom_churn
group by MultipleLines,Contract;

-- To confirm the above Insight 
select Contract,count(*) from telecom_churn where Churn = 'Yes' group by Contract;
-- and yes it does confirm

--Payment Method Differences
select Contract,count(*) from telecom_churn where Churn = 'Yes' group by Contract;

-- trying to find any relation between gender and Tenure

SELECT gender,
       CASE
         WHEN tenure < 12 THEN '0-1 Year'
         WHEN tenure < 24 THEN '1-2 Years'
         ELSE '>2 Years'
       END AS tenure_group,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telecom_churn
GROUP BY gender,
         CASE
           WHEN tenure < 12 THEN '0-1 Year'
           WHEN tenure < 24 THEN '1-2 Years'
           ELSE '>2 Years'
         END
ORDER BY gender, tenure_group;

--Found out that most customers regardless of them being male or female are getting churned in the timespan of 0-1 years.

--This analysis combining Paperless Billing + Contract Type is telling us exctly the root causes of our problems
select PaperlessBilling,contract, count(*) as total_customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as num_churn,
round(100* sum(case when Churn = 'Yes' then 1 else 0 end)/count(*),2) as per_churn,
sum(case when Churn = 'Yes' then TotalCharges else 0 end) as Total_lost
from telecom_churn group by PaperlessBilling,contract;

-- Many of the people with ane lectronic payment method have the most churned customers

select PaymentMethod, count(*) as total_customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as num_churn,
round(100* sum(case when Churn = 'Yes' then 1 else 0 end)/count(*),2) as per_churn,
sum(case when Churn = 'Yes' then TotalCharges else 0 end) as Total_lost
from telecom_churn group by PaymentMethod;

--Since we found out the major factors that are compromising the churn rate of the data hence we created 
-- a churn score and bifurcated the customers based on the churn_score and created a new column name risk_level.

SELECT *,
CASE 
WHEN churn_score >= 5 THEN 'High Risk'
WHEN churn_score BETWEEN 3 AND 4 THEN 'Medium Risk'
ELSE 'Low Risk'
END AS risk_level
FROM (
SELECT *,
CASE 
WHEN Contract = 'Month-to-month' THEN 2 ELSE 0 
END +
CASE 
WHEN tenure < 6 THEN 2 ELSE 0 
END +
CASE 
WHEN TechSupport = 'No' THEN 1 ELSE 0 
END +
CASE 
WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 
END AS churn_score
FROM telecom_churn
) AS scored_data;
