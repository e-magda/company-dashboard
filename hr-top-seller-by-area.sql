SELECT
  CONCAT(e.lastName, ' ', e.firstName) AS name, 
  oc.territory AS territory,
  SUM(od.quantityOrdered * od.priceEach) AS turnover,
  round((SUM(od.quantityOrdered * od.priceEach) - SUM(od.quantityOrdered * p.buyPrice))/SUM(od.quantityOrdered * od.priceEach) * 100, 2) AS margin_rate,
  (SELECT round((SUM(od.quantityOrdered * od.priceEach) - SUM(od.quantityOrdered * p.buyPrice))/SUM(od.quantityOrdered * od.priceEach) * 100, 2)
    FROM offices oc
      JOIN employees e ON e.officeCode = oc.officeCode
      JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
      JOIN orders o ON c.customerNumber = o.customerNumber
      JOIN orderdetails od ON o.orderNumber = od.orderNumber
      JOIN products p ON  od.productCode = p.productCode
    WHERE TO_DAYS(o.orderDate) >= TO_DAYS(now()) - 60) AS global_margin_rate
FROM offices oc
  JOIN employees e ON e.officeCode = oc.officeCode
  JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
  JOIN orders o ON c.customerNumber = o.customerNumber
  JOIN orderdetails od ON o.orderNumber = od.orderNumber
  JOIN products p ON  od.productCode = p.productCode
WHERE TO_DAYS(o.orderDate) >= TO_DAYS(now()) - 60
GROUP BY c.salesRepEmployeeNumber, territory
ORDER BY territory, turnover DESC;
