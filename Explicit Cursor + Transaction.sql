---- Stored Procedure with Explicit Cursor + Transaction
--CREATE OR REPLACE PROCEDURE GENERATE_EMPLOYEE_REPORT IS
--    CURSOR emp_cursor IS
--        SELECT e.ID, e.SALARY, 
--               ROUND((a.CHECK_OUT - a.CHECK_IN) * 24, 2) AS HOURS_WORKED
--        FROM EMPLOYEE_SALARY e
--        JOIN ATTENDANCE a ON e.ID = a.EMPLOYEE_ID
--        WHERE e.SALARY > 100000;
--
--    v_id EMPLOYEE_SALARY.ID%TYPE;
--    v_salary EMPLOYEE_SALARY.SALARY%TYPE;
--    v_hours NUMBER;
--
--BEGIN
--    FOR emp_record IN emp_cursor LOOP
--        BEGIN
--            INSERT INTO EMPLOYEE_REPORT (EMPLOYEE_ID, SALARY, HOURS_WORKED)
--            VALUES (emp_record.ID, emp_record.SALARY, emp_record.HOURS_WORKED);
--
--            COMMIT;  -- Commit for each successful insert
--
--        EXCEPTION
--            WHEN OTHERS THEN
--                ROLLBACK;  -- Rollback that specific iteration on error
--                DBMS_OUTPUT.PUT_LINE('Failed to insert for ID: ' || emp_record.ID);
--        END;
--    END LOOP;
--END;
--/
