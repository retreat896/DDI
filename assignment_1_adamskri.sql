-- Schema and Tables
-- Create a schema named assignment_1 in your database.
CREATE SCHEMA IF NOT EXISTS assignment_1 ;

-- Create a table called persons to store the data in person.csv.
CREATE TABLE
    persons (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(50),
        middle_name VARCHAR(50),
        last_name VARCHAR(50),
        major VARCHAR(50),
        minor VARCHAR(50),
        favorite_food VARCHAR(50),
        favorite_color VARCHAR(50),
        favorite_programming_language VARCHAR(50),
        student VARCHAR(50)
    );

-- Create a table called pets to store the data in pet.csv.
CREATE TABLE
    pets (
        id SERIAL PRIMARY KEY,
        pet_name VARCHAR(50),
        pet_type VARCHAR(50),
        pet_age INT,
        virtual_pet VARCHAR(50),
        has_fur BOOLEAN DEFAULT TRUE,
        owner VARCHAR(50),
        owner_id INTEGER,
        CONSTRAINT pets_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES persons(id)
    );

-- Write SQL to copy the rows in person.csv and insert them into the persons table.
-- SOURCE: https://stackoverflow.com/questions/2987433/how-to-import-csv-file-data-into-a-postgresql-table
COPY persons
FROM
    'C:\Users\krisa\Desktop\Code\Class\DDI\person.csv'
WITH
    (FORMAT csv);

-- Write SQL to copy the rows in pet.csv and insert them into the pets table.s
COPY pets
FROM
    'C:\Users\krisa\Desktop\Code\Class\DDI\pet.csv'
WITH
    (FORMAT csv);

-- Table Alterations
-- Add a deleted column (BOOLEAN) - Default value: FALSE
-- SOURCE: https://www.w3schools.com/postgresql/postgresql_add_column.php
ALTER TABLE persons ADD deleted BOOLEAN DEFAULT FALSE;

ALTER TABLE pets ADD deleted BOOLEAN DEFAULT FALSE;

-- Add a created_at column (TIMESTAMP WITH TIME ZONE) - Default value: CURRENT_TIMESTAMP
-- SOURCE: https://www.w3schools.com/sql/func_mysql_current_timestamp.asp
ALTER TABLE persons ADD created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE pets ADD created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;

-- Add an updated_at column (TIMESTAMP WITH TIME ZONE)
-- SOURCE: https://www.w3schools.com/sql/sql_datatypes.asp
ALTER TABLE persons ADD updated_at TIMESTAMP WITH TIME ZONE;
ALTER TABLE pets ADD updated_at TIMESTAMP WITH TIME ZONE;

-- Constraints
--   Add NOT NULL constraints to: 
--     person.first_name, person.last_name, pet.pet_name, pet.pet_type
-- SOURCE: https://www.w3schools.com/sql/sql_ref_alter_column.asp
-- SOURCE: https://www.w3schools.com/sql/sql_ref_not_null.asp
ALTER TABLE persons ALTER COLUMN first_name SET NOT NULL; 
ALTER TABLE persons ALTER COLUMN last_name SET NOT NULL;

ALTER TABLE pets ALTER COLUMN pet_name SET NOT NULL;
ALTER TABLE pets ALTER COLUMN pet_type SET NOT NULL;

--   Delete violating rows before adding the constraint
--   Add a UNIQUE constraint to pets so that multiple pets for the same 
--     owner cannot have the same name.
ALTER TABLE pets ADD CONSTRAINT pets_owner_pet_name_unique UNIQUE (owner_id, pet_name);

--   Create a magic_number column (INTEGER) in person. 
--   The value must be within 5 of the row’s id, or NULL.
-- AI PROMPT: is this valid syntax
--    `ALTER TABLE persons ADD magic_number int CONSTRAINT ((magic_number <= LAST_INSERT_ID()+6 AND magic_number >= LAST_INSERT_ID()-4)OR magic_number = NULL);`
ALTER TABLE persons ADD COLUMN magic_number INTEGER;
ALTER TABLE persons ADD CONSTRAINT persons_magic_number_chk CHECK (
    magic_number IS NULL OR (magic_number >= id - 5 AND magic_number <= id + 5)
);

-- Table Updates
--   Change all majors from "computer science" to "Computer Science".
-- SOURCE: https://www.w3schools.com/sql/sql_update.asp
UPDATE persons SET major = 'Computer Science' WHERE major = 'computer science';

--   Change all majors from "software engineering" to "Software Engineering".
UPDATE persons SET major = 'Software Engineering' WHERE major = 'software engineering';

--   Set magic_number = (id + 1) for rows where id is divisible by 4.
UPDATE persons SET magic_number = id + 1 WHERE id % 4 = 0;

-- Queries
--   Select first and last names of all Software Engineering majors, ordered by last name ASC.
SELECT first_name, last_name FROM persons WHERE major = 'Software Engineering' ORDER BY last_name;

--   Select all cats (case-insensitive), ordered by:
--     "owner_id (ASC)", "pet_id (ASC)"
SELECT * FROM pets WHERE pet_type ILIKE 'cat' ORDER BY owner_id, id;

--   Select all pets with fur where:
--     "owner_id < 10 OR", "owner_id > 20"
SELECT * FROM pets WHERE has_fur = TRUE AND (owner_id < 10 OR owner_id > 20);

-- Foreign Key Operations
--   Write SQL to delete a person and show whether you get an error.
DELETE FROM persons WHERE id > 0;

--   Write SQL to change the foreign key to add ON DELETE CASCADE.
ALTER TABLE pets DROP CONSTRAINT IF EXISTS pets_owner_id_fkey;
ALTER TABLE pets
    ADD CONSTRAINT pets_owner_id_fkey
    FOREIGN KEY (owner_id) REFERENCES persons(id) ON DELETE CASCADE;

--   Write SQL to delete a person again and show whether you get an error.
DELETE FROM persons WHERE id > 0;
