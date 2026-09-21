1.Creating a database

CREATE DATABASE company_db;

2.To check the table is created or not

USE company_db;

3.Showing the table

SHOW DATABASES;

4.Creating a table

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE NOT NULL
);


5.Description of table

DESC departments;

6.Inserting a values

INSERT INTO departments
VALUES (1, 'Computer Science');

INSERT INTO departments
VALUES (2, 'Mechanical');


7.Showing the entire table data

SELECT * FROM departments;


8.Creating a employee table

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    email VARCHAR(100) UNIQUE,

    salary DECIMAL(10,2) CHECK (salary > 0),

    city VARCHAR(50) DEFAULT 'Bangalore',

    department_id INT,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);


9.Inserting a data into employees

INSERT INTO employees
(employee_id, name, email, salary, department_id)
VALUES
(101, 'Rahul', 'rahul@gmail.com', 50000, 1);