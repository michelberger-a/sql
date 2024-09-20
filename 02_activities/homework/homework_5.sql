-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */


-- select vendor and product names
-- make sure to include spend
SELECT 
v.vendor_name
, p.product_name
, SUM(spend) as total_spend
FROM (
-- create a distinct list of vendors + products
-- cross join to create the list of customer to vendors + products
	SELECT DISTINCT vi.vendor_id
	, vi.product_id
	, vi.original_price
	, c.customer_id
	, vi.original_price * 5 as spend
	FROM vendor_inventory as vi
	CROSS JOIN customer c
) as step1
	
-- joins to assign vendor names and product names for final output
LEFT JOIN vendor as v
	ON step1.vendor_id = v.vendor_id
LEFT JOIN product as p
	ON step1.product_id = p.product_id
GROUP BY step1.vendor_id, step1.product_id




-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */


-- drop table first
-- create the temp table with requirements
DROP TABLE IF EXISTS temp.product_units;
CREATE TEMP TABLE product_units as
	SELECT * 
	, CURRENT_TIMESTAMP as snapshot_timestamp
	FROM product
	WHERE product_qty_type = 'unit';


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

-- add my own product and details
INSERT INTO product_units
VALUES(105, 'Butter Tarts - Pecan', 'medium', 1, 'unit', '2024-09-20 20:00:00');



-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

-- delete my own new product
DELETE FROM product_units
WHERE product_id = 105;


-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */



-- last quantity for each product
-- order product by market_date desc and retrieve first VALUES
WITH last_inv as (
	SELECT quantity
	, product_id
	FROM (
	SELECT * 
	, SUM(quantity) as total_quantity
	, ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY market_date DESC) as order_num
	FROM vendor_inventory
	-- to get all quantity from the last date
	-- in case multiple orders occured for the same products
	GROUP BY product_id, market_date
	) as step1
	WHERE order_num = 1
	)
	
	, all_inv as (
	-- join with products so we can account for all products
	-- make sure to change nulls to 0 with coalesce
	SELECT p.product_id
	, COALESCE(quantity, 0) as quantity
	FROM product as p
	LEFT JOIN last_inv as li
		ON p.product_id = li.product_id
	)

-- final UPDATE
-- make sure to match on the product id in the where statement
-- and set the currrent_quantity to what we calculated
UPDATE product_units
SET current_quantity = all_inv.quantity
FROM all_inv
WHERE product_units.product_id = all_inv.product_id;	
