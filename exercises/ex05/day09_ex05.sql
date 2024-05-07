DROP FUNCTION fnc_persons_male();
DROP FUNCTION fnc_persons_female();

CREATE OR REPLACE FUNCTION fnc_persons(
 pgender varchar DEFAULT 'female'
) RETURNS TABLE ( id bigint,  name varchar,  age integer, gender varchar, address varchar
) AS
$$
    BEGIN
    RETURN QUERY SELECT * FROM person WHERE person.gender = pgender;
END;
$$ LANGUAGE plpgsql;

select *
from fnc_persons(pgender := 'male');

select *
from fnc_persons();
