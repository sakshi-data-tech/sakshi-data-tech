use adv_works;
CREATE TABLE SALES AS
SELECT * FROM FactInternetSales
UNION ALL
SELECT * FROM Fact_Internet_Sales_New;

select * from Sales;

SELECT COUNT(*) FROM SALES;
DESC DimProduct;
select * from sales;

desc sales;

#Q3
SELECT YEAR(OrderDateKey) AS Year FROM SALES;

SELECT MONTH(OrderDateKey) AS MonthNo FROM SALES;

SELECT MONTHNAME(OrderDateKey) AS MonthName FROM SALES;

SELECT CONCAT('Q', QUARTER(OrderDateKey)) AS Quarter FROM SALES;

SELECT DATE_FORMAT(OrderDateKey, '%Y-%b') AS YearMonth FROM SALES;

SELECT DAYOFWEEK(OrderDateKey) AS WeekdayNumber FROM SALES;

SELECT DAYNAME(OrderDateKey) AS WeekdayName FROM SALES;

#fin_Month
SELECT 
CASE 
    WHEN MONTH(OrderDateKey) >= 4 
    THEN MONTH(OrderDateKey) - 3
    ELSE MONTH(OrderDateKey) + 9
END AS FinancialMonth
FROM SALES;

#fin_Quater
SELECT 
CASE 
    WHEN MONTH(OrderDateKey) BETWEEN 4 AND 6 THEN 'Q1'
    WHEN MONTH(OrderDateKey) BETWEEN 7 AND 9 THEN 'Q2'
    WHEN MONTH(OrderDateKey) BETWEEN 10 AND 12 THEN 'Q3'
    ELSE 'Q4'
END AS FinancialQuarter
FROM SALES;

#q4

SELECT 
    (UnitPrice * OrderQuantity) - DiscountAmount AS SalesAmount

FROM SALES;



ALTER TABLE SALES ADD COLUMN SalesAmountCalc DOUBLE;
SET SQL_SAFE_UPDATES = 0;
UPDATE SALES
SET SalesAmountCalc = 
    (UnitPrice * OrderQuantity) - DiscountAmount;
    
select * from sales;

-- Q5 Production Cost
ALTER TABLE SALES ADD COLUMN ProductionCost DOUBLE;
UPDATE SALES
SET ProductionCost = ProductStandardCost * OrderQuantity;


-- Q6 Profit
ALTER TABLE SALES ADD COLUMN Profit DOUBLE;

select * from sales;

-- Q7
CREATE TABLE month_sales (
    MonthNo INT,
    MonthName VARCHAR(20),
    TotalSales DECIMAL(10,2)
);

INSERT INTO month_sales (MonthNo, MonthName, TotalSales)
SELECT 
    MonthNo,
    MonthName,
    ROUND(SUM(SalesAmountCalc),2)
FROM SALES
GROUP BY MonthNo, MonthName
ORDER BY MonthNo;

SELECT * FROM month_sales;

#Q8

SELECT 
    Year,
    ROUND(SUM(SalesAmountCalc),2) AS TotalSales
FROM SALES
GROUP BY Year
ORDER BY Year;

#Q9

SELECT 
    MonthNo,
    MonthName,
    ROUND(SUM(SalesAmountCalc),2) AS TotalSales
FROM SALES
GROUP BY MonthNo, MonthName
ORDER BY MonthNo;

#Q9.1
SELECT 
    Year,
    MonthNo,
    MonthName,
    ROUND(SUM(SalesAmountCalc),2) AS TotalSales
FROM SALES
GROUP BY Year, MonthNo, MonthName
ORDER BY Year, MonthNo;

#Q10
Select
 YEAR(order_date)AS Year,
 CONCAT('Q',QUARTER(order_date)) AS Quarter,
 SUM(sales_amount) AS Total_Sales
 FROM sales_table
 GROUP BY YEAR(order_date),QUARTER(order_date)
 ORDER BY Year, Quarter;
 
 #Q11
 SELECT
  DATE_FORMAT(date,'%Y-%m') AS month,
  SUM(sales_amount) AS total_sales,
  SUM(producction_cost) AS total_cost
  FROM production_sales
  GROUP  BY DATE_FORMAT(date,'%Y-%m')
  ORDER BY month;
  
  #Q12.1
  SELECT
  product_name,
  SUM(quantity*unit_price) AS total_sales
  FROM sales
  GROUP BY product_name
  ORDER BY total_sales DESC;
  
  #Q12.2
  SELECT
  customer_name,
  SUM(quantity*unit_price) AS total_revenue
  FROM sales
  GROUP BY customer_name
  ORDER BY total_revenue DESC;
  
  #Q12.3
  SELECT
  region,
  SUM(quantity*unit_price) AS total_sales
  FROM sales
  GROUP BY region
  ORDER BY total_sales DESC;
  
  
  
 
 