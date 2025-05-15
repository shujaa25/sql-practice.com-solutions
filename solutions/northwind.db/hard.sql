--Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late, "Not Shipped" if shipped_date is null.
--Order by employee last_name, then by first_name, and then descending by number of orders.
select first_name, last_name, count(*) as num_orders,
case
	when shipped_date <= required_date then 'On Time'
	when shipped_date is null then 'Not Shipped'
	else 'Late'
end as Shipped
from orders
join employees using(employee_id)
group by first_name, last_name, Shipped
order by last_name, first_name, num_orders desc;

--Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places
select year(order_date) as yr, round(sum(quantity * unit_price * (discount)),2)
from orders
join order_details using(order_id)
join products using(product_id)
group by yr
order by yr desc;