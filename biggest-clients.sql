SELECT customerName, SUM(quantityOrdered*priceEach) AS spending, (SUM(quantityOrdered*priceEach)*100/AVG(turnover)) AS turnoverShare
FROM customers
JOIN orders
	ON customers.customerNumber = orders.customerNumber
JOIN orderdetails AS details
	ON orders.orderNumber = details.orderNumber
CROSS JOIN (SELECT SUM(quantityOrdered*priceEach) as turnover 
            FROM orders
            JOIN orderdetails AS details
                    ON orders.orderNumber = details.orderNumber
            WHERE orderDate >= '2021-01-01'	AND status != 'Cancelled'		
            ORDER BY turnover DESC) AS turnover
WHERE orderDate >= '2021-01-01' AND status != 'Cancelled'
GROUP BY customerName
ORDER BY spending DESC
LIMIT 5;
