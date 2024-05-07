CREATE OR REPLACE FUNCTION func_minimum(
    VARIADIC arr numeric[]
) RETURNS TABLE (min_value numeric) AS
$$
BEGIN
    RETURN QUERY
    SELECT MIN(value) AS min_value
    FROM unnest(arr) AS t(value);
END;
$$ LANGUAGE plpgsql;




SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);