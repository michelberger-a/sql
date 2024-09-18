-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

-- how many times a vendor has rented a booth
SELECT vendor_id
, COUNT(market_date) as num_booth_assignments
FROM vendor_booth_assignments
GROUP BY vendor_id;

/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

WITH spent_total as (
SELECT customer_id, (quantity * cost_to_customer_per_qty) as spent
FROM customer_purchases
)
SELECT c.customer_first_name, c.customer_last_name
FROM spent_total as sp
LEFT JOIN customer as c
	ON sp.customer_id = c.customer_id
GROUP BY sp.customer_id
HAVING sum(sp.spent) > 2000
ORDER BY c.customer_last_name, c.customer_first_name;


--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

-- remove iteration of previous tables
DROP TABLE IF EXISTS temp.new_vendor;

-- create the new table
CREATE TEMP TABLE new_vendor AS 
SELECT *
FROM vendor;

-- add the data for new vendor
INSERT INTO temp.new_vendor
VALUES(10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');


-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

-- retrieve the id, the month ('%m') and the year ('%Y') values
SELECT customer_id
, STRFTIME('%m', market_date) as Month
, STRFTIME('%Y', market_date) as Year
FROM customer_purchases;

/* 2. Using the previous query as a base, determine how much money each customer spent in April 2022. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */


-- make sure to select our grouping variable and aggregate variable
SELECT customer_id
, SUM(spend) as total_spend

-- subquery so we can preset our calculations and make aggregation easier
FROM (
SELECT *
, STRFTIME('%m', market_date) as Month
, STRFTIME('%Y', market_date) as Year
, quantity * cost_to_customer_per_qty as spend
FROM customer_purchases
) as step1

-- can't forget to filter for our month of interest
WHERE month = '04' AND Year = '2022'
GROUP BY customer_id;

