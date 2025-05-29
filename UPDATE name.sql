select * from employee_salary;
ALTER TABLE EMPLOYEE_SALARY
ADD NAME VARCHAR2(100);

UPDATE empsalary SET name = 'Rupa Das' WHERE id = 34;
UPDATE empsalary SET name = 'Sourav Roy' WHERE id = 35;
-- Repeat for all 35 employees
COMMIT;
SELECT table_name FROM user_tables WHERE LOWER(table_name) LIKE '%salary%';
UPDATE EMPLOYEE_SALARY SET name = 'Rupa Das' WHERE id = 34;
UPDATE EMPLOYEE_SALARY SET name = 'Sourav Roy' WHERE id = 35;
COMMIT;
