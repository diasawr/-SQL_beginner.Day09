CREATE TABLE person_audit
(
    created TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    type_event CHAR(1) NOT NULL DEFAULT 'I',
    row_id BIGINT NOT NULL,
    name VARCHAR,
    age INTEGER,
    gender VARCHAR,
    address VARCHAR,
    CONSTRAINT ch_type_event CHECK (type_event IN ('I', 'D', 'U'))
);

--drop table person_audit


-- Create a Trigger Function
CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO person_audit(created,type_event,row_id,name,age,gender,address)
    VALUES (current_timestamp, 'I',NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create a Trigger
CREATE TRIGGER trg_person_insert_audit
AFTER INSERT ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_insert_audit();

INSERT INTO person (id,name,age,gender,address)
VALUES(10,'Damir',22,'male','Irkutsk');

SELECT *
FROM person_audit;

--DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
--DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit ;

--delete from person where id = 10
--select *
--from person;