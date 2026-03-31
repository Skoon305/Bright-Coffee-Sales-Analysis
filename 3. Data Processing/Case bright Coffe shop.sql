---Query 1: running the entire table
select * from workspace.default.`1771947879858_bright_coffee_shop_sales` limit 100;








---2: Checking date range
SELECT
    MIN(transaction_date) AS miniumum_date,
    MAX(transaction_date) AS maximun_date
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;








---3: Checking different Store locations
SELECT DISTINCT store_location
From`workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;








---4: Checking product CategorySold at our Store
SELECT DISTINCT Product_category
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;








---5:Checking product Types Sold at our Store 
SELECT DISTINCT product_type 
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;




---6:Checking Product Detail sold at our Stores
SELECT DISTINCT product_detail
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;



--7:cHECKING FOR NULLS IN VARIUOS COLUMNS
SELECT*
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`
WHERE unit_price IS NULL 
OR transaction_qty IS NULL
OR transaction_date IS NULL;








---8:Checking Lowest and Highest Unit price
SELECT MIN(unit_price) AS lowest_price,
MAX(unit_price) AS Highest_price 
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;


---9: Extracting the day and month names
SELECT
transaction_date,
Dayname(transaction_date) AS day_name,
Monthname(transaction_date) AS month_name
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;

---10: Calculatin the revenue
SELECT unit_price,
       transaction_qty,
       unit_price*transaction_qty AS Revenue
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;

---11:combining functions to get a clean enhance datasets
SELECT
transaction_id,
transaction_date,
transaction_time,
transaction_qty,
store_id,
store_location,
product_id,
unit_price,
product_category,
product_type,
product_detail,
---Adding columns to enhance the table for better insights
--New column added 1
Dayname(transaction_date) AS Day_name,
---New column added 2
Monthname(transaction_date) AS Month_name,
---New column added 3
Dayofmonth(Transaction_date) AS Date_of_month,
---New Column added 4 - Determining Weekday/Weekend
CASE
WHEN Dayname(transaction_date) IN ('Sunday','Saturday') THEN 'Weekend'
ELSE 'weekdays'
END AS Day_classification,
---New Column added 5 - Time buckets
CASE 
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '05:00:00' AND '08:59:59' THEN '01.Rush Hour'
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN '02.Mid Morning'
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN '03.Afternoon'
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '16:00:00' AND '17:59:59' THEN '04.Evening'
ELSE '05.night'
END AS time_classification,
---New Column added 6 -Spend buckets
CASE 
WHEN (transaction_qty*unit_price) <=50 THEN '01.Low Spend'
WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN '02. Medium spend'
WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03. Moreki'
ELSE '04.Blesser'
END AS Spend_bucket,
---New column added 7 - Revenue
transaction_qty*unit_price AS Revenue
FROM `workspace`.`default`.`1771947879858_bright_coffee_shop_sales`;

