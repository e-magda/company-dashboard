SELECT 
	SUM(CASE WHEN year(o.orderDate) = year(current_date) THEN (quantityOrdered * priceEach) ELSE 0 END) as turnover_current_year,
    round(SUM(CASE WHEN year(o.orderDate) = year(current_date) THEN (quantityOrdered * priceEach) ELSE 0 END) / month(current_date) * 12, 2) as proj_turnover_current_year,
    SUM(CASE WHEN year(o.orderDate) = year(current_date)-1 THEN (quantityOrdered * priceEach) ELSE 0 END) as turnover_last_year,
    round(((SUM(CASE WHEN year(o.orderDate) = year(current_date) THEN (quantityOrdered * priceEach) ELSE 0 END) / month(current_date) * 12)- (SUM(CASE WHEN year(o.orderDate) = year(current_date)-1 THEN (quantityOrdered * priceEach) ELSE 0 END)))/SUM(CASE WHEN year(o.orderDate) = year(current_date)-1 THEN (quantityOrdered * priceEach) ELSE 0 END) * 100, 2) as progression_proj_current_year_from_last_year
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE o.status != 'Cancelled';
