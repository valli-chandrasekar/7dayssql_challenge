create database sqlchallenge;
use sqlchallenge;

-- customers

create table customers(
    customer_id int PRIMARY KEY,
    full_name varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    city varchar(50) NOT NULL,
    signup_date date NOT NULL,
    segment varchar(50) NOT NULL
);

-- products

create table products(
    product_id int PRIMARY KEY,
    product_name varchar(100) NOT NULL,
    category  varchar(100) NOT NULL,
    price decimal(10,2) NOT NULL,
    cost decimal(10,2) NOT NULL
);

-- orders

create table orders(
    order_id int PRIMARY KEY,
    customer_id int,
    order_date date NOT NULL,
    status varchar(50) NOT NULL,
    channel varchar(50) NOT NULL,

    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

-- order_items

create table order_items(
    order_item_id int PRIMARY KEY,
    order_id int,
    product_id int,
    quantity int NOT NULL,
    unit_price decimal(10,2) NOT NULL,
    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

-- payments

create table payments(
    payment_id int PRIMARY KEY,
    order_id int UNIQUE,
    payment_method varchar(50) NOT NULL,
    payment_status varchar(50) NOT NULL,
    amount decimal(10,2) NOT NULL,

    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

-- deliveries

create table deliveries(
    delivery_id int PRIMARY KEY,
    order_id int UNIQUE,
    dispatch_date date NOT NULL,
    delivery_date date NULL,
    delivery_status varchar(50),

    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);


-- load data 

-- show data

select * from customers;
select * from products;
select * from orders;
select * from order_items;
select * from payments;
select * from deliveries;










