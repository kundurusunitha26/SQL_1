CREATE VIEW department_salary_summary AS
SELECT d.department_name, 
COUNT(e.employee_id) AS employee_count,
AVG(e.salary) AS average_salary,
MAX(e.salary) AS highest_salary,
MIN(e.salary) AS lowest_salary
FROM departments d
LEFT JOIN employees e
 ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

select * from department_salary_summary;
 
 CREATE OR REPLACE VIEW high_salary_employees AS 
 SELECT employee_id,employee_name,salary,department_id 
 FROM employees
 WHERE salary > 70000;
 
 select * from high_salary_employees;
 DROP VIEW high_salary_employees;
 DELIMITER //
 CREATE FUNCTION annual_salary1(monthly_salary DECIMAL(10,2))
 RETURNS DECIMAL(12,2)
 DETERMINISTIC
 BEGIN 
    RETURN monthly_salary * 12;
END //
DELIMITER ;

SELECT employee_name,salary,annual_salary(salary) AS yearly_salary
FROM employees;
 
DELIMITER //

CREATE FUNCTION salary_category(
    monthly_salary DECIMAL(10,2)
)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    IF monthly_salary >= 70000 THEN
        RETURN 'High Salary';
    ELSEIF monthly_salary >= 50000 THEN
        RETURN 'Medium Salary';
    ELSE
        RETURN 'Low Salary';
    END IF;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_All_employees()
BEGIN
SELECT * FROM employees;
END //
DELIMITER ;
CALL get_all_employees();

DELIMITER //
CREATE PROCEDURE get_employees_by_department(
IN dept_id INT
)
BEGIN
SELECT employee_id,employee_name,salary,department_id 
FROM employees 
WHERE department_id = dept_id;
END //
DELIMITER ;
CALL get_employees_by_department(1);

DELIMITER //
CREATE PROCEDURE add_employee(
IN emp_name VARCHAR(100),
IN emp_email VARCHAR(100),
IN emp_salary DECIMAL(10,2),
IN dept_id INT,
IN join_date date
)
BEGIN 
INSERT INTO employees(employee_name,email,salary,department_id,joining_date)
VALUES(emp_name,emp_salary,dept_id,join_date);
END //
DELIMITER ;
CALL add_employee('vijay','vijay@gmail.com',65000,1,'2026-01-15');

DELIMITER //
CREATE PROCEDURE update_employee_salary(
IN emp_id INT,
IN new_salary DECIMAL(10,2)
)
BEGIN
UPDATE employees
SET salary = new_salary
WHERE employee_id = emp_id;
END //
DELIMITER ;
CALL update_employee_salary(2, 70000);

DELIMITER //
CREATE PROCEDURE delete_employee_salary(
IN emp_id INT
)
BEGIN
DELETE FROM employees
WHERE employee_id = emp_id;
END //
DELIMITER ;
CALL delete_employee_salary(2, 70000);


DELIMITER //
CREATE PROCEDURE check_salary(
	IN emp_id INT
)
BEGIN
	DECLARE emp_salary DECIMAL(10,2);
    SELECT salary
    INTO emp_salary
    FROM employees
    WHERE employee_id = emp_id;
    IF emp_salary >= 70000 THEN
		SELECT 'High Salary' AS result;
	ELSEIF emp_salary >= 50000 THEN
		SELECT 'Medium Salary' AS result;
	ELSE 
		SELECT 'Low Salary' AS result;
	END IF;
END //
DELIMITER ;