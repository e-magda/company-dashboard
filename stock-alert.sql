SELECT productName, p.productCode, quantityInStock, sum(quantityOrdered*priceEach) as turnover, sum(quantityOrdered)
FROM products p
JOIN orderdetails o
  ON o.productCode = p.productCode
GROUP BY quantityInStock
HAVING quantityInStock <= 600
ORDER BY quantityInStock;
