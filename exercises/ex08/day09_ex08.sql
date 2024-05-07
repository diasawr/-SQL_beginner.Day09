CREATE OR REPLACE FUNCTION fnc_fibonacci
    (IN pstop INTEGER DEFAULT 10)
RETURNS SETOF INT AS $$
DECLARE
    fib_val INT;
BEGIN
    FOR fib_val IN
        WITH RECURSIVE Fibonacci AS (
            SELECT 1 AS n, 0 AS fib1, 1 AS fib2
            UNION ALL
            SELECT n + 1, fib2, fib1 + fib2
            FROM Fibonacci
            WHERE fib1 < pstop
        )
        SELECT fib1
        FROM Fibonacci
        WHERE fib1 < pstop
    LOOP
        RETURN NEXT fib_val;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();
