create database asgnmnt3;
use asgnmnt3;

create table Customers ( -- Creating table Customers
customer_id int primary key,
customer_name varchar (50),
customer_email varchar (50),
customer_phone varchar (20)
);

insert into Customers (customer_id, customer_name, customer_email, customer_phone) -- Inserting values in the table by GPT
values 
(1, 'John Doe', 'john@example.com', '1234567890'),
(2, 'Jane Smith', 'jane@example.com', '0987654321'),
(3, 'Michael Brown', 'michael@example.com', '1112223333');

select * from Customers; -- checking

create table Products ( -- Creating table Products
product_id int primary key, 
product_name varchar (50),
product_price decimal 
);

insert into Products (product_id, product_name, product_price) -- Inserting values in the table by GPT
values 
(1, 'Laptop', 1200.50),
(2, 'Smartphone', 799.99),
(3, 'Tablet', 450.00);

select * from Products; -- checking

create table Place ( -- Creating table Place
place_id int primary key,
place_type varchar (20),
place_name varchar (50),
place_adress varchar (50)
);
 
insert into Place (place_id, place_type, place_name, place_adress) -- Inserting values in the table by GPT
values 
(1, 'Store', 'Best Electronics', '123 Market St'),
(2, 'Warehouse', 'Main Warehouse', '456 Industrial Rd'),
(3, 'Store', 'Tech Haven', '789 Retail Plaza');

select * from Place; -- checking

create table Orders ( -- Creating table Orders
order_id int primary key, 
customer_id int,
product_id int, 
place_id int,
order_date date,
quantity int,
foreign key (customer_id) references Customers (customer_id),
foreign key (product_id) references Products (product_id),
foreign key (place_id)  references Place (place_id)
);

insert into Orders (order_id, customer_id, product_id, place_id, order_date, quantity) -- Inserting values in the table by GPT
values 
(1, 1, 1, 1, '2024-09-01', 1),
(2, 2, 2, 1, '2024-09-03', 2),
(3, 3, 3, 2, '2024-08-06', 1),
(4, 1, 2, 3, '2024-09-06', 1),
(5, 2, 3, 2, '2024-08-07', 1),
(6, 3, 1, 1, '2024-09-09', 3),
(7, 1, 3, 1, '2024-09-09', 2),
(8, 2, 1, 3, '2024-09-10', 1),
(9, 3, 2, 2, '2024-09-11', 2),
(10, 1, 2, 3, '2024-09-12', 1);

select * from Orders; -- checking

create table Payments ( -- Creating table Orders
payments_id int primary key,
order_id int, 
payment_date date,
payment_bank varchar (50),
foreign key (order_id) references Orders (order_id)
);

insert into Payments (payments_id, order_id, payment_date, payment_bank) -- Inserting values in the table by GPT
values 
(1, 1, '2024-09-02', 'Chase'),
(2, 2, '2024-09-04', 'Bank of America'),
(3, 3, '2024-08-06', 'Wells Fargo'),
(4, 4, '2024-09-06', 'Chase'),
(5, 5, '2024-08-08', 'Bank of America'),
(6, 6, '2024-09-09', 'Wells Fargo'),
(7, 7, '2024-09-10', 'Chase'),
(8, 8, '2024-09-11', 'Bank of America'),
(9, 9, '2024-09-12', 'Wells Fargo'),
(10, 10, '2024-09-13', 'Chase');

select * from Payments; -- checking

with Consumer_total_september as(select c.customer_name, sum(p.product_price*o.quantity) as total_price, count(o.order_id) as total_orders, 
max(o.order_date) as last_order_date, max(pmt.payment_date) as payment -- columns
	from Orders o
	join Customers c ON o.customer_id = c.customer_id
	join Products p ON o.product_id = p.product_id
	join Place pl ON o.place_id = pl.place_id
	join Payments pmt ON o.order_id = pmt.order_id -- joining
	where o.order_date >= '2024-09-01' -- condition
	group by c.customer_name -- grouping
), -- CTE 
Consumer_total_before_september as(select c.customer_name, sum(p.product_price*o.quantity) as total_price, count(o.order_id) as total_orders, 
max(o.order_date) as last_order_date, max(pmt.payment_date) as payment -- columns
	from Orders o
	join Customers c ON o.customer_id = c.customer_id
	join Products p ON o.product_id = p.product_id
	join Place pl ON o.place_id = pl.place_id
	join Payments pmt ON o.order_id = pmt.order_id -- joining
	where o.order_date < '2024-09-01' -- condition
	group by c.customer_name -- grouping
) -- CTE
select * from Consumer_total_september
union all 
select * from Consumer_total_before_september
order by total_price desc;