------------------------------------CREATING DataBase---------------------------
create database HotelDatabase
use HotelDatabase

-------------------------------------CREATING TABLE-----------------------------

create table salesman
(
salesman_id int primary key,
name char (30),
city char (30),
commission float
)
insert into salesman values (5001,'James Hoog','New York',0.15),(5002,'Nail Knite','paris',0.13),(5005,'Pit Alex','London',0.11),(5006,'Mc Lyon','Paris',0.14),(5007,'Paul Adam','Rome',0.13),(5003,'Lauson Hen','San Jose',0.12)
select * from salesman
drop table order_table_
create table order_table_
(
ord_no int primary key,
purch_amt float,
ord_date date,
customer_id int,
saleman_id int foreign key references salesman (salesman_id)
)
select * from order_table_
insert into order_table_ values(70001,150.5,'2012-10-05',3005,5002),(70009,270.65,'2012-09-10',3001,5005),(70002,65.26,'2012-10-05',3002,5001),(70004,110.5,'2012-08-17',3009,5003),(70007,948.5,'2012-09-10',3005,5002),(70005,2400.6,'2012-07-27',3007,5001),(70008,5760,'2012-09-10',3002,5001),(70010,1983.43,'2012-10-10',3004,5006),(70003,2480.4,'2012-10-10',3009,5003),(70012,250.45,'2012-06-27',3008,5002),(70011,75.29,'2012-08-17',3003,5007),(70013,3045.6,'2012-04-25',3002,5001)
create table Customer
(
customer_id int primary key,
cust_name char (30),
city char (30),
grade int,
salesman_id int foreign key references salesman (salesman_id)
)
select * from  Customer 
insert into Customer values (3002,'Nick Rimando','New York',100,5001),(3007,'Brad Davis','New York',200,5001),(3005,'Graham Zusi','California',200,5002),(3008,'Julian Green','London',300,5002),(3004,'Fabian Johnson','Paris',300,5006),(3009,'Geoff Cameron','Berlin',100,5003),(3003,'Jozy Altidor','Moscow',200,5007),
(3001,'Brad Guzan','london',' ',5005)



--Q1. Write a query to find those customers with their name and those salesmen with their name and city who lives in the same city.
SELECT customer.cust_name,
salesman.name, salesman.city
FROM salesman, customer
WHERE salesman.city = customer.city

--Q2. Write a SQL statement to find the names of all customers along with the salesmen who works for them.
SELECT customer.cust_name, salesman.name
FROM customer,salesman
WHERE salesman.salesman_id = customer.salesman_id

--Q3. Write a SQL statement to display all those orders by the customers not located in the same cities where their salesmen live.
SELECT ord_no, cust_name, orders.customer_id,
orders.salesman_id
FROM salesman, customer, orders
WHERE customer.city <> salesman.city
AND orders.customer_id = customer.customer_id
AND orders.salesman_id = salesman.salesman_id

--Q4. Write a SQL statement that finds out each order number followed by the name of the customers who made the order.
SELECT orders.ord_no, customer.cust_name
FROM orders, customer
WHERE orders.customer_id = customer.customer_id

--Q5. Write a SQL statement that sorts out the customer and their grade who made an order. Each of the customers must have a grade and served by at least a salesman, who belongs to a city.
SELECT customer.cust_name AS "Customer",
customer.grade AS "Grade"
FROM orders, salesman, customer
WHERE orders.customer_id = customer.customer_id
AND orders.salesman_id = salesman.salesman_id
AND salesman.city IS NOT NULL
AND customer.grade IS NOT NULL

--Q6. Write a query that produces all customers with their name, city, salesman and commission, who served by a salesman and the salesman works at a rate of the commission within 12% to 14%.
SELECT customer.cust_name AS "Customer",
customer.city AS "City",
salesman.name AS "Salesman",
salesman.commission
FROM customer,salesman
WHERE customer.salesman_id = salesman.salesman_id
AND salesman.commission
BETWEEN .12 AND .14

--Q7. Write a SQL statement that produces all orders with the order number, customer name, commission rate and earned commission amount for those customers who carry their grade is 200 or more and served by an existing salesman.
SELECT ord_no, cust_name, commission AS
"Commission%",
purch_amt*commission AS "Commission"
FROM salesman,orders,customer
WHERE orders.customer_id = customer.customer_id
AND orders.salesman_id = salesman.salesman_id
AND customer.grade>=200
--Q8. Find all customers with orders on October 5, 2012.
SELECT *FROM customer a,orders b 
WHERE a.customer_id=b.customer_id 
AND b.ord_date='2012-10-05';

--Q9. Write a SQL statement to display the commission with the percent sign ( % ) with salesman ID, name and city columns for all the salesmen.
SELECT salesman_id,name,city,'%',commission*100
FROM salesman;

--Q10. Write a SQL statement to find out the number of orders booked for each day and display it in such a format like "For 2001-10-10 there are 15 orders".
SELECT ' For',ord_date,',there are',
COUNT (DISTINCT ord_no),'orders.'
FROM orders 
GROUP BY ord_date;

--Q11. Write a query to display the orders according to the order number arranged by ascending order.
SELECT *
FROM orders 
ORDER BY ord_no;

--Q12. Write a SQL statement to arrange the orders according to the order date in such a manner that the latest date will come first then previous dates.
SELECT *
FROM orders 
ORDER BY ord_date DESC;

--Q13. Write a SQL statement to display the orders with all information in such a manner that, the older order date will come first and the highest purchase amount of same day will come first.
SELECT *
FROM orders 
ORDER BY ord_date, purch_amt DESC;

--Q14. Write a SQL statement to display the customer name, city, and grade, etc. and the display will be arranged according to the smallest customer ID.
SELECT cust_name,city,grade 
FROM customer 
ORDER BY customer_id;

--Q15. Write a SQL statement to make a report with salesman ID, order date and highest purchase amount in such an arrangement that, the smallest salesman ID will come first along with their smallest order date.
SELECT salesman_id,ord_date,MAX(purch_amt)
FROM orders 
GROUP BY salesman_id,ord_date 
ORDER BY salesman_id,ord_date;

--Q16. Write a SQL statement to display customer name, city and grade in such a manner that, the customer holding highest grade will come first.
SELECT cust_name,city,grade 
FROM customer 
ORDER BY 3 DESC;

--Q17. Write a SQL statement to make a report with customer ID in such a manner that, the largest number of orders booked by the customer will come first along with their highest purchase amount.
SELECT customer_id, COUNT(DISTINCT ord_no),
MAX(purch_amt)
FROM orders 
GROUP BY customer_id 
ORDER BY 2 DESC;

--Q18. Write a SQL statement to make a report with order date in such a manner that, the latest order date will come last along with the total purchase amount and total commission (15% for all salesmen) for that date.
SELECT ord_date, SUM(purch_amt),
SUM(purch_amt)*.15
FROM orders 
GROUP BY ord_date 
ORDER BY ord_date;