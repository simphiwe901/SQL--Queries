-- Basic Queries, to test knowledge
-- 03/08/17

-- 1)Show all information in the offices relation
SELECT *FROM offices;

-- 2)Show any one tuple in the payments relation (just one, no more).
SELECT *FROM payments where customerNumber = 103 and amount < 5000;

-- 3)Show how many tuples there are in the orders relation
SELECT count(*) as No_of_turples from orders;

-- 4)Show all employees tuples where reportsTo is the same as employeeNumber
SELECT *from employees where employees.employeeNumber = employees.reportsTo; -- no turple in employees that matches

-- 5)Show all information in the payments relation for payments exceeding 100 000, 
-- in decreasing order (i.e. from highest payment downwards).
SELECT *from payments where amount > 100000 order by(amount)desc;

-- 6)Show all information in the employees relation for employeeNumbers 1188 and 1504.
SELECT *from employees where employeeNumber=1188  or employeeNumber = 1504;

-- 7)	Show the productCode of all products having their quantityInStock below 100, 
-- along with their total price. The total price is the buyPrice  plus VAT (VAT is 14% of buyPrice).
select productCode, buyPrice*114/100 as Total_price from products where quantityInStock <100;

-- 8)What is the average payment amount in the database?
select avg(round(amount)) as Average_Total_Payment from payments;

-- 9)In how many cities are offices located (how many cities have offices in them) ?
select count(city) as number_of_cities from offices;


-- 10)Show all information in the offices relation where the state is missing/unknown.  
select *from offices where state is null;

-- 11)Show the customerNumber and amount for all payments  
-- with a ‘Q’ as the 2nd character of the checkNumber (a check is a cheque!)
select customerNumber, amount from payments where checkNumber like '_q%';

-- 12)What jobTitles exist in the database?
select distinct jobTitle from employees;

-- 13)Show productName and buyPrice of the product(s) with the highest buyPrice.
select productName, buyPrice from products group by(buyPrice) having (buyPrice)>=60 
order by(buyPrice)desc; -- product name with buyPrice of at least 60 is assumed to be high

-- 14)	Show orderNumber, status, quantityOrdered and productName 
-- for all products from productVendor ‘Exoto Designs’ that have status ‘Cancelled’.
-- select *from products;

select c.orderNumber,status,quantityOrdered, productName from products as a, orders as b,
orderdetails as c where b.orderNumber = c.orderNumber and a.productCode = c.productCode 
and a.productVendor like 'E%s' and b.status like 'C%d';


-- 15)Show the productCode of all products that have never been ordered
select a.productCode from products, orderdetails as a where a.productCode = products.productCode
and quantityOrdered = 0; -- assumption is that a product with zero quantityOrdered is declaired as
-- not ordered




-- 16)Show how many employees there are in each office (give officeCode and value each time).
select count(employees.officeCode) as number_of_employees_in_each_office, employees.officeCode from employees, 
offices where employees.officeCode = offices.officeCode
group by(employees.officeCode) having(employees.officeCode)>=1;

-- 17)	Show how many customers each employee is associated with (as salesRepEmployeeNumber), 
-- but only for employees who are the salesRepEmployeeNumber for at least 1 customer. 
-- Give employeeNumber and value each time.
select count(customers.salesRepEmployeeNumber) as salesRepEmployeeNumber, employees.employeeNumber from customers,
employees where customers.salesRepEmployeeNumber = employees.employeeNumber
group by(customers.salesRepEmployeeNumber) having(employees.employeeNumber) >= 1002; -- assumption is that 
-- salesRepEmployeeNumber must match employeeNumber for the employee to be associated with at least one customer
-- otherwise there is a zero to zero relationship


-- 18)	What was the total value of orderNumber 10100 
-- i.e. the total of (quantityOrdered * priceEach) over all its orderlines?
select sum(round(quantityOrdered*priceEach, 2)) as total_value_of_orderNumber_10100
from orderdetails where orderNumber=10100;

-- 19)Show the productName of the product/s with the largest quantityInStock.
select productName, quantityInStock from products group by(quantityInStock)desc 
having(quantityInStock) >=1000; -- assumption is that products starting from 1000
-- are considered large. They are ranked from highest ranking of largest to lower ranking
-- of largest.

-- 20)Show the employeeNumber of employees who reportsTo the same person 
-- as does employeeNumber 1313 (i.e. who have the same boss as 1313).
select *from employees;
select reportsTo from employees where employeeNumber = 1313; -- shows which person this employee reportsTo
-- in this case the employee does not exist in the database, hence it would be impossible to do any operation
-- suppose we take employeeNumber 1056, for illustation.
select employeeNumber from employees where reportsTo < 1056; -- this shows all employees that reports to the same 
-- person including the person in reference

-- 21)Show the employeeNumber of all employees who are superiors of employeeNumber 1313 
-- (i.e. the person 1313 reportsTo, and the employee who that person reportsTo, ... all the way up)
-- employeeNumber does not exist in the database.
-- suppose we take employeeNumber equal to 1088

select employeeNumber from employees group by(reportsTo) having(employeeNumber)<=1088;

-- 22)Devise a useful query of your own involving the most interesting usage of SQL you can think of. 
-- Explain clearly in a comment what it is meant to find from the database. Also explain how you know the SQL for this query is correct (showing intermediate results if necessary). 
-- Marks here will be proportional to the complexity and usefulness of the query you implement.

select *from employees;

SELECT * FROM employees WHERE lastName REGEXP '^b'; -- this query retrieves all entries of lastName with the first letter
-- being b. This query is efficient and useful reletive to like 'b%' which can be sometimes confusing.
-- consider another example where jobTitle starts with an s.
SELECT * FROM employees WHERE jobTitle REGEXP '^s'; -- this entry works and saves time.

-- 23)Add a new office to the database, giving it officeCode 999 (meaning planned for later). 
-- This office will be in Cape Town, but no other details are known yet. Make state ‘Western Province’.
-- select *from offices;
INSERT INTO offices VALUES('999','','','','','Western Province','','','');

-- 24)Employee 1313 is superstitious. Change their employee number in the database, 
-- giving them the employee number 1 greater than the largest employee number in the database.
-- select *from employees;
-- employeeNumber does not exist in the current database. Either way the query is as follows

update employees set employeeNumber = 1703 where employeeNumber=1313;

-- 25)OrderNumber 10101 was never signed by the customer. Remove it from the database.
delete from orders where orderNumber = 10101;
delete from orderdetails where orderNumber = 10101;
 










