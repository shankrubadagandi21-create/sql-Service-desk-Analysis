-- 3.Create database and tables

CREATE DATABASE service_desk_analytics;
USE service_desk_analytics;


CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
location VARCHAR(50)
);
select * from customers;

CREATE TABLE support_teams (
team_id INT PRIMARY KEY,
team_name VARCHAR(100)
);

CREATE TABLE tickets(
ticket_id INT PRIMARY KEY,
customer_id INT,
team_id INT,
created_at DATETIME,
resolved_at DATETIME,
priority VARCHAR(20),
status VARCHAR(30),

FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
FOREIGN KEY (team_id) REFERENCES teams (team_id)
);

CREATE TABLE sla_rules(
priority VARCHAR (50) PRIMARY KEY,
resolution_hours INT 
);

CREATE TABLE ticket_history(
history_id INT PRIMARY KEY,
ticket_id INT,
status VARCHAR(100),
changed_at DATETIME,

FOREIGN KEY (ticket_id) REFERENCES tickets (ticket_id)
);
