--bulk processing
create or replace NONEDITIONABLE PROCEDURE BULK_INSERT_REPORT IS
    TYPE emp_tab IS TABLE OF EMPLOYEE_SALARY.ID%TYPE;
    TYPE sal_tab IS TABLE OF EMPLOYEE_SALARY.SALARY%TYPE;
    TYPE hr_tab IS TABLE OF NUMBER;

    emp_ids emp_tab;
    salaries sal_tab;
    hours hr_tab;

BEGIN
    SELECT e.ID, e.SALARY, ROUND((a.CHECK_OUT - a.CHECK_IN) * 24, 2)
    BULK COLLECT INTO emp_ids, salaries, hours     --bulk added to peroform faster
    FROM EMPLOYEE_SALARY e
    JOIN ATTENDANCE a ON e.ID = a.EMPLOYEE_ID
    WHERE e.SALARY > 100000;

    FORALL i IN 1 .. emp_ids.COUNT
        INSERT INTO EMPLOYEE_REPORT (EMPLOYEE_ID, SALARY, HOURS_WORKED)
        VALUES (emp_ids(i), salaries(i), hours(i));

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Bulk insert failed: ' || SQLERRM);
END;
