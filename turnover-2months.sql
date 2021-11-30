#  The turnover of the orders of the last two months by country

SELECT oc.country, MONTH(o.orderDate), SUM(od.quantityOrdered*od.priceEach) as turnover
FROM orderdetails od
JOIN orders AS o
	ON o.orderNumber = od.orderNumber
JOIN customers c
	ON c.customerNumber = o.customerNumber 
JOIN employees e
	ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices oc
	ON oc.officeCode = e.officeCode
WHERE 
	CASE
		WHEN MONTH(CURRENT_DATE) = 1 THEN (MONTH(o.orderDate) = MONTH(current_date) AND YEAR(o.orderDate) = YEAR(current_date)) OR (MONTH(o.orderDate) = MONTH(current_date)-1 AND YEAR(o.orderDate) = YEAR(current_date)-1) OR (MONTH(o.orderDate) = MONTH(current_date)-2 AND YEAR(o.orderDate) = YEAR(current_date)-1)
		WHEN MONTH(CURRENT_DATE) = 2 THEN (MONTH(o.orderDate) = MONTH(current_date) AND YEAR(o.orderDate) = YEAR(current_date)) OR (MONTH(o.orderDate) = MONTH(current_date)-1 AND YEAR(o.orderDate) = YEAR(current_date)) OR (MONTH(o.orderDate) = MONTH(current_date)-2 AND YEAR(o.orderDate) = YEAR(current_date)-1)
    ELSE (MONTH(o.orderDate) = MONTH(current_date)-1 AND YEAR(o.orderDate) = YEAR(current_date)) OR (MONTH(o.orderDate) = MONTH(current_date)-2 AND YEAR(o.orderDate) = YEAR(current_date))
	END
GROUP BY oc.country, MONTH(o.orderDate)
ORDER BY turnover DESC;
