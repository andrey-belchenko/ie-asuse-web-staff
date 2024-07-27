drop table  if exists sale;
CREATE TABLE sale (
    customer VARCHAR(50),
    dat DATE,
    product VARCHAR(50),
    sale INTEGER
);

INSERT INTO sale (customer, dat, product, sale) VALUES 
('Customer1', '2023-01-10', 'Product1', 1000),
('Customer1', '2023-02-15', 'Product2', 1500),
('Customer1', '2023-03-20', 'Product1', 2500),
('Customer2', '2023-01-20', 'Product3', 400),
('Customer2', '2023-02-10', 'Product2', 200),
('Customer2', '2023-02-20', 'Product2', 800),
('Customer2', '2023-04-15', 'Product3', 2500),
('Customer2', '2023-05-10', 'Product3', 300);


drop table  if exists payment;
CREATE TABLE payment (
    customer VARCHAR(50),
    dat DATE,
    payment INTEGER
);

INSERT INTO payment (customer, dat, payment) VALUES
('Customer1', '2023-01-20', 700),
('Customer1', '2023-02-10', 100),
('Customer1', '2023-03-10', 300),
('Customer1', '2023-03-15', 2000),
('Customer1', '2023-04-15', 1000),
('Customer2', '2023-01-15', 500),
('Customer2', '2023-02-15', 100),
('Customer2', '2023-03-15', 300),
('Customer2', '2023-03-20', 100),
('Customer2', '2023-04-20', 3000),
('Customer2', '2023-05-15', 200);


drop table  if exists months;
CREATE TABLE months AS
SELECT 
 	to_char(d, 'YYYY.MM') AS name,
    date_trunc('month', d)::date AS begin_date,
    (date_trunc('month', d) + INTERVAL '1 month' - INTERVAL '1 day')::date AS end_date
FROM 
    generate_series('2023-01-01'::date, '2023-12-31'::date, '1 month'::interval) d;



