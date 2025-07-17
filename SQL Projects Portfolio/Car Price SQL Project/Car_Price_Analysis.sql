create database Car_Price;
use Car_Price;
select * from car;
-- 1. Basic Stats--
SELECT COUNT(*) AS total_cars, MIN(price) AS min_price, MAX(price) AS max_price,
ROUND(AVG(price), 2) AS avg_price FROM car;

-- 2. Average Price By Make--
SELECT make, COUNT(*) AS model_count, ROUND(AVG(price), 2) AS avg_price FROM car
GROUP BY make ORDER BY avg_price DESC LIMIT 10;

-- 3. Fuel Type vs Price Comparison--
SELECT `fuel type`, COUNT(*) AS total, ROUND(AVG(price), 2) AS avg_price
FROM car GROUP BY `fuel type`;

-- 4. Top Body Styles by Avg Price--
SELECT `body style`,COUNT(*) AS total, ROUND(AVG(price), 2) AS avg_price
FROM car GROUP BY `body style` ORDER BY avg_price DESC;

--  5. Aspiration Impact on Price--
SELECT aspiration, ROUND(AVG(price), 2) AS avg_price
FROM car GROUP BY aspiration;

-- 6. Engine Size Bin Analysis--
SELECT CASE 
WHEN `engine size` < 100 THEN '< 100cc'
WHEN `engine size` BETWEEN 100 AND 150 THEN '100 - 150cc'
WHEN `engine size` BETWEEN 151 AND 200 THEN '151 - 200cc'
ELSE '> 200cc' END AS engine_category,
COUNT(*) AS total, ROUND(AVG(price), 2) AS avg_price
FROM car GROUP BY engine_category ORDER BY avg_price DESC;

-- 7. Mileage Efficiency vs Price (City & Highway)--
SELECT `city mpg`,`highway mpg`,ROUND(AVG(price), 2) AS avg_price
FROM car GROUP BY `city mpg`, `highway mpg`ORDER BY avg_price DESC
LIMIT 10;

-- 8. Cylinder vs Price Impact--
SELECT `num of cylinders`,COUNT(*) AS total, ROUND(AVG(price), 2) AS avg_price
FROM car GROUP BY `num of cylinders`ORDER BY avg_price DESC;

-- 9. Symboling (Risk) vs Price--
SELECT symboling, COUNT(*) AS models, ROUND(AVG(price), 2) AS avg_price
FROM car GROUP BY symboling ORDER BY symboling;

-- 10. Top 10 Heaviest Cars by Curb Weight--
SELECT make, `curb weight`, price FROM car ORDER BY `curb weight` DESC LIMIT 10;

-- 11. Compression Ratio vs Price Correlation (Binned) --
SELECT CASE 
WHEN `compression ratio` < 9 THEN 'Low Compression'
WHEN `compression ratio` BETWEEN 9 AND 10 THEN 'Moderate'
ELSE 'High Compression'
END AS compression_bin, ROUND(AVG(price), 2) AS avg_price FROM car GROUP BY compression_bin order by avg_price desc;

-- 12. Window Function – Rank Cars by Horsepower within Each Body Style --
SELECT make,`body style`,horsepower,price, RANK() OVER (PARTITION BY `body style` ORDER BY horsepower DESC) AS hp_rank
FROM car;




