--Stored Procedure using Implicit Cursor (FORALL + BULK INSERT)
CREATE OR REPLACE PROCEDURE bulk_insert_report IS

    TYPE emp_tab IS
        TABLE OF employee_salary.id%TYPE;
    TYPE sal_tab IS
        TABLE OF employee_salary.salary%TYPE;
    TYPE hr_tab IS
        TABLE OF NUMBER;
    emp_ids  emp_tab;
    salaries sal_tab;
    hours    hr_tab;
BEGIN
    SELECT
        e.id,
        e.salary,
        round((a.check_out - a.check_in) * 24, 2)
    BULK COLLECT
    INTO
        emp_ids,
        salaries,
        hours
    FROM
             employee_salary e
        JOIN attendance a ON e.id = a.employee_id
    WHERE
        e.salary > 100000;

    FORALL i IN 1..emp_ids.count
        INSERT INTO employee_report (
            employee_id,
            salary,
            hours_worked
        ) VALUES ( emp_ids(i),
                   salaries(i),
                   hours(i) );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Bulk insert failed: ' || sqlerrm);
END;
/