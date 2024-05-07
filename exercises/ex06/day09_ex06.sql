CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
    pperson varchar DEFAULT 'Dmitriy',
    pprice numeric DEFAULT 500,
    pdate date DEFAULT '2022-01-08'
) RETURNS TABLE (name varchar) AS
$$
BEGIN
    RETURN QUERY SELECT pz.name
    FROM person_visits AS pv
    JOIN person AS p ON p.id = pv.person_id
    JOIN menu AS m ON m.pizzeria_id = pv.pizzeria_id
    JOIN pizzeria AS pz ON pz.id = m.pizzeria_id
    WHERE p.name = pperson AND m.price < pprice AND pv.visit_date = pdate;
END;
$$ LANGUAGE plpgsql;


select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_daate(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');