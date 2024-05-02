-- »ç¿øÀÇ first_name, employee_id, department_id, dept_name
SELECT
    E.employee_id,
    E.first_name,
    E.department_id,
    D.department_name
FROM employees E
INNER JOIN departments D
ON E.department_id = D.department_id
ORDER BY E.employee_id
;


SELECT
    E.employee_id,
    E.first_name,
    E.department_id,
    D.department_name
FROM employees E
INNER JOIN departments D
ON E.department_id = D.department_id
AND E.maneger_id = D.manager_id
ORDER BY E.employee_id
;




SELECT
    E.employee_id,
    E.first_name,
    department_id,
    D.department_name
FROM employees E
INNER JOIN departments D
USING (department_id, manager_id)
ORDER BY E.employee_id
;

















































