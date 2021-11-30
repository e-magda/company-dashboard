# The number of products sold by category and by month, with comparison and 
# rate of change compared to the same month of the previous year.

SELECT 
	p.productLine as category, 
	month(o.orderDate) as month, 
  SUM(CASE WHEN YEAR(o.orderDate) = year(current_date) THEN quantityOrdered ELSE 0 END) AS products_sold_current_year,
  SUM(CASE WHEN YEAR(o.orderDate) = year(current_date)-1 THEN quantityOrdered ELSE 0 END) AS products_sold_last_year,
  round((SUM(CASE WHEN YEAR(o.orderDate) = year(current_date) THEN quantityOrdered ELSE 0 END)-SUM(CASE WHEN year(o.orderDate) = year(current_date)-1 THEN quantityOrdered ELSE 0     END))/SUM(CASE WHEN year(o.orderDate) = year(current_date)-1 THEN quantityOrdered ELSE 0 END) * 100, 2) AS change_rate
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE year(o.orderDate) = 2021 or year(o.orderDate) = 2020
GROUP BY category, month
ORDER BY category, month;
