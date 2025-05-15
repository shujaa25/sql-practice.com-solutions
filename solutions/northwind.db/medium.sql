--Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table
SELECT product_name, company_name, category_name
FROM products, suppliers, categories
where products.category_id = categories.category_id and
suppliers.supplier_id = products.supplier_id;

--Show the category_name and the average product unit price for each category rounded to 2 decimal places.
SELECT category_name, round(sum(unit_price)/count(*), 2)
FROM categories
join products using (category_id)
group by category_name;

--Show the city, company_name, contact_name from the customers and suppliers table merged together.
--Create a column which contains 'customers' or 'suppliers' depending on the table it came from.
SELECT city, company_name, contact_name, 'customers' as rel
FROM customers
UNION
SELECT city, company_name, contact_name, 'suppliers' as rel
FROM suppliers;

--Show the total amount of orders for each year/month.
SELECT year(order_date), month(order_date), count(*)
FROM orders
group by year(order_date), month(order_date);