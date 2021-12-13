SELECT p.productName, p.productCode, p.quantityInStock, SUM(quantityOrdered) AS quantity_ordered_in_current_quarter
FROM products p
JOIN orderdetails od
	ON od.productCode = p.productCode
JOIN orders o
	ON o.orderNumber = od.orderNumber
WHERE 
  CASE
    WHEN MONTH(CURRENT_DATE) = 1 THEN (MONTH(o.orderDate) = MONTH(current_date) AND YEAR(o.orderDate) = YEAR(current_date)) OR (MONTH(o.orderDate) = MONTH(current_date)-1 AND YEAR(o.orderDate) = YEAR(current_date)-1) OR (MONTH(o.orderDate) = MONTH(current_date)-2 AND YEAR(o.orderDate) = YEAR(current_date)-1)
    WHEN MONTH(CURRENT_DATE) = 2 THEN (MONTH(o.orderDate) = MONTH(current_date) AND YEAR(o.orderDate) = YEAR(current_date)) OR (MONTH(o.orderDate) = MONTH(current_date)-1 AND YEAR(o.orderDate) = YEAR(current_date)) OR (MONTH(o.orderDate) = MONTH(current_date)-2 AND YEAR(o.orderDate) = YEAR(current_date)-1)
    ELSE (MONTH(o.orderDate) = MONTH(current_date)-1 AND YEAR(o.orderDate) = YEAR(current_date)) OR (MONTH(o.orderDate) = MONTH(current_date)-2 AND YEAR(o.orderDate) = YEAR(current_date))
  END
GROUP BY productName, p.productCode, quantityInStock
ORDER BY quantity_ordered_in_current_quarter DESC 
LIMIT 5;
