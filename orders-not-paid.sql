SELECT total_orders_shipped - payments AS orders_shipped_not_paid
FROM 
  (SELECT SUM(od.quantityOrdered * od.priceEach) AS total_orders_shipped
   FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
   WHERE status = "Shipped" or status = "Resolved" or status = "On hold") AS total_orders,
  (SELECT SUM(p.amount) AS payments
   FROM payments p) AS payments_received;
