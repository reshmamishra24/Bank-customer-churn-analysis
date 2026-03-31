SELECT COUNT(*) FROM BankChurn_EDA
USE BankChurnDB
ALTER TABLE BankChurn_EDA
ADD CONSTRAINT PK_Customer PRIMARY KEY
(CustomerID);


/* 
Project Title : Bank Customer Churn Analysis 
Database : BankChurnDB
Tool Used : SQL Server (SSMS)
Objective : Identify Churn drivers and high-risk customer segments
Author : Reshma Mishra
*/

--1. Total Customers
SELECT COUNT(*) AS Total_Customers
FROM BankChurn_EDA;

--2. Total Churned Customers
SELECT COUNT(*) AS Total_Churned
FROM BankChurn_EDA
WHERE Exited=1;

--3. Overall Churn Rate
SELECT 
    SUM(CASE WHEN Exited=1 THEN 1 ELSE 0 END) *100.0
        / COUNT(*) AS Churn_Rate
FROM BankChurn_EDA;

--4. Average Balance (Churned vs Retained)
SELECT 
 Exited,
    AVG(Balance) AS Avg_Balance
FROM BankChurn_EDA
GROUP BY Exited;

--5. Churn Rate by Geography
SELECT GeographyCategory,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited=1 THEN 1  ELSE 0 END) AS Total_Churned,
     SUM(CASE WHEN Exited =1 THEN 1 ELSE 0 END) * 100.0
     / COUNT(*) AS Churn_Rate
FROM BankChurn_EDA
GROUP BY GeographyCategory
ORDER BY Churn_Rate DESC;

-- 6. Churn Rate by Gender
SELECT 
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Total_Churned,
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*) AS Churn_Rate
FROM BankChurn_EDA
GROUP BY Gender
ORDER BY Churn_Rate DESC;

-- 7. Churn Rate by Age Group
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Below 30'
        WHEN Age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Above 50'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Total_Churned,
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*) AS Churn_Rate
FROM BankChurn_EDA
GROUP BY 
    CASE 
        WHEN Age < 30 THEN 'Below 30'
        WHEN Age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Above 50'
    END
ORDER BY Churn_Rate DESC;

-- 8. Churn Rate by Active Status
SELECT 
    IsActiveMember,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Total_Churned,
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*) AS Churn_Rate
FROM BankChurn_EDA
GROUP BY IsActiveMember
ORDER BY Churn_Rate DESC;

-- 9. Churn Rate by Tenure
SELECT 
    Tenure,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Total_Churned,
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*) AS Churn_Rate
FROM BankChurn_EDA
GROUP BY Tenure
ORDER BY Tenure;

-- 10. Churn Rate by Number of Products
SELECT 
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Total_Churned,
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*) AS Churn_Rate
FROM BankChurn_EDA
GROUP BY NumOfProducts
ORDER BY Churn_Rate DESC;

-- 11. High Balance Customers Who Churned
SELECT *
FROM BankChurn_EDA
WHERE Exited = 1
AND Balance > (SELECT AVG(Balance) FROM BankChurn_EDA);

-- 12. Top 3 High-Risk Geographies
WITH Geo_Churn AS (
    SELECT 
        GeographyCategory,
            SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 
            / COUNT(*) AS Churn_Rate
    FROM BankChurn_EDA
    GROUP BY GeographyCategory
)

SELECT *,
       DENSE_RANK() OVER (ORDER BY Churn_Rate DESC) AS Risk_Rank
FROM Geo_Churn;

-- 13. Low Tenure and Inactive Customers
SELECT *
FROM BankChurn_EDA
WHERE Tenure <= 2
AND IsActiveMember = 0;

-- 14. Average Credit Score Comparison
SELECT 
    Exited,
    ROUND(AVG(CreditScore), 2) AS Avg_CreditScore
FROM BankChurn_EDA
GROUP BY Exited;

-- 15. Single Product Customers Churn Analysis
SELECT 
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Total_Churned,
    ROUND(
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Churn_Rate
FROM BankChurn_EDA
GROUP BY NumOfProducts
HAVING NumOfProducts = 1;

--16. Top 3 High-Risk Age Groups (Using DENSE_RANK)
WITH AgeChurn AS (
SELECT
CASE
WHEN Age < 30 THEN 'Below 30'
WHEN Age BETWEEN 30 AND 50 THEN '30-50'
ELSE 'Above 50'
END AS Age_Group,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Churn_Rate
FROM BankChurn_EDA
GROUP BY
CASE
WHEN Age < 30 THEN 'Below 30'
WHEN Age BETWEEN 30 AND 50 THEN '30-50'
ELSE 'Above 50'
END
)

SELECT Age_Group,
DENSE_RANK() OVER (ORDER BY Churn_Rate DESC) AS Risk_Rank
FROM AgeChurn;

/* 
    SQL Analysis - Key Insights 

    1.

    2.

    3.

    4.

    5.

    Conclusion : 
*/