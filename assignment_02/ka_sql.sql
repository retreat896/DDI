SET search_path = hr_db_ka;
SHOW search_path;

CREATE VIEW emp_view AS
(
SELECT employee_id, first_name, last_name
FROM employees
WHERE job_id = 9
ORDER BY employee_id
);

SELECT * FROM employees;

SELECT * FROM emp_view;

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id)
VALUES (209,'Eve','Gietz','eve.gietz@sqltutorial.org','515.123.8181','1994-06-07',9,8300.00,205,11);

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id)
VALUES (211,'New_Member','Gietz','madeline.gietz@sqltutorial.org','515.123.8181','1994-06-07',9,8300.00,205,11);

SELECT * FROM employees;

SELECT * FROM emp_view;

UPDATE emp_view
SET first_name = 'new_David'
WHERE employee_id = 105;

SELECT * FROM emp_view;

GRANT SELECT, UPDATE, INSERT ON emp_view TO ashrafuzzamm;

CREATE MATERIALIZED VIEW emp_prog AS
(
SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE job_id = 9
ORDER BY employee_id
);

SELECT * FROM emp_prog;

UPDATE employees
SET first_name = 'New First Name'
WHERE first_name = 'Eve';

SELECT * FROM emp_prog;

REFRESH MATERIALIZED VIEW emp_prog;

SELECT * FROM emp_prog;