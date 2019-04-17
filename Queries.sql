-- Simple Queries -- 

//Manufacturers with profits between $20 billion and $40 billion
SELECT Name 
FROM manufacturer_t
WHERE PROFIT BETWEEN 20000000000 AND 40000000000;

//Designers who work for Adidas with Model and product id
SELECT DESIGNER, MODEL, PRODUCT_ID
FROM product_t
WHERE NAME = 'Adidas'
ORDER BY product_ID DESC

//Hourly Employees or Joey
SELECT NAME 
FROM employee_t
WHERE EMPLOYEE_TYPE = 'Hourly' OR NAME LIKE '%Joey%';

//Manufactureres from boston
SELECT NAME
FROM manufacturer_t
WHERE ADDRESS LIKE '%BOSTON%'




-- Intermediate Queries -- 

//Profits from companies in CA 
SELECT SUM(PROFIT)
FROM manufacturer_t
WHERE ADDRESS LIKE '%_CA_%';

//Sum of all salaries grouped by store 
SELECT STORE_ID, COUNT(e.EMPLOYEE_ID) AS Employees, SUM(s.SALARY) AS Expense
FROM employee_t e, salary_t s
WHERE s.EMPLOYEE_ID = e.EMPLOYEE_ID
GROUP BY STORE_ID;

//Name of employee who's store has no phone number 
SELECT NAME
FROM employee_t
WHERE STORE_ID = 
		(SELECT STORE_ID
         FROM distributor_t
         WHERE PHONE_NUM IS NULL);

-- Advanced Queries --

//Customer names who spent more than $200
SELECT c.name, p.price 
FROM customer_t c JOIN package_t p ON c.CUSTOMER_ID = p.CUSTOMER_ID
WHERE p.price > 200
ORDER BY p.PRICE ASC;

//Displays all manufacturers Kanye has worked for 
SELECT NAME 
FROM manufacturer_t m 
WHERE EXISTS 
		(SELECT *
         FROM product_t p 
         WHERE m.NAME = p.NAME AND p.DESIGNER LIKE '%Kanye%');

//Creates a view for limited releases
CREATE VIEW Limited_Releases
AS	SELECT p.MODEL, p.COLORWAY, p.DESIGNER
	FROM product_t p LEFT JOIN released_t r ON p.PRODUCT_ID = r.PRODUCT_ID
	WHERE r.TYPE = 'Limited Release';


