--Show the category_name and description from the categories table sorted by category_name.
SELECT category_name, description
FROM categories order by category_name;

--Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
SELECT contact_name, address, city
FROM customers where country not in ('Germany', 'Mexico', 'Spain');

--Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
SELECT order_date, shipped_date, customer_id, freight
FROM orders where order_date = DATE('2018-02-26');

--Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date
SELECT employee_id, order_id, customer_id, required_date, shipped_date
FROM orders where shipped_date > required_date;

--Show all the even numbered Order_id from the orders table
SELECT order_id
FROM orders where order_id%2==0;

--Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name
SELECT city, company_name, contact_name
FROM customers where city LIKE '%L%'
order by contact_name;

--Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
SELECT company_name, contact_name, fax
FROM customers where fax is not null;

--Show the first_name, last_name. hire_date of the most recently hired employee.
SELECT first_name, last_name, hire_date
FROM employees order by hire_date desc limit 1;

--Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.
SELECT round(avg(unit_price),2), sum(units_in_stock), sum(discontinued)
FROM products;
