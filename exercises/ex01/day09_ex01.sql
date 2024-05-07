CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert the old state into person_audit
    INSERT INTO person_audit (type_event, row_id, name, age, gender, address)
    VALUES ('U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a Trigger for UPDATE
CREATE TRIGGER trg_person_update_audit
BEFORE UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_update_audit();

UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
