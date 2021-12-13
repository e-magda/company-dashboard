SELECT e.employeeNumber,
  CONCAT(e.lastName, ' ', e.firstName) AS name, 
  SUM(od.quantityOrdered * od.priceEach) AS turnover
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE o.status != 'Cancelled' AND
  CASE
    WHEN MONTH(CURRENT_DATE) = 1 THEN MONTH(orderDate) = MONTH(current_date)-1 AND YEAR(orderDate) = YEAR(current_date)-1
    ELSE MONTH(orderDate) = MONTH(current_date)-1 AND YEAR(orderDate) = YEAR(current_date)
  END
GROUP BY c.salesRepEmployeeNumber
ORDER BY turnover DESC
LIMIT 2;
