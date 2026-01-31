
LOAD DATA LOCAL INFILE '/Users/jacquesduval/Desktop/person.csv'
INTO TABLE persons
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(first_name, middle_name, last_name, major, minor, favorite_food, favorite_color, favorite_programming_language, student, age);

LOAD DATA LOCAL INFILE '/Users/jacquesduval/Desktop/pet.csv'
INTO TABLE pets
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(pet_name, pet_type, pet_age, virtual_pet, has_fur, owner_name);

ALTER TABLE pets ADD COLUMN owner_id INT;

ALTER TABLE pets ADD CONSTRAINT fk_pets_owner
FOREIGN KEY (owner_id) REFERENCES persons(id);

SET SQL_SAFE_UPDATES = 0;

UPDATE pets p
JOIN persons per ON p.owner_name = per.first_name
SET p.owner_id = per.id;

ALTER TABLE persons ADD COLUMN deleted BOOLEAN DEFAULT FALSE;
ALTER TABLE pets ADD COLUMN deleted BOOLEAN DEFAULT FALSE;

ALTER TABLE persons ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE pets ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE persons ADD COLUMN updated_at TIMESTAMP;
ALTER TABLE pets ADD COLUMN updated_at TIMESTAMP;

DELETE FROM persons WHERE first_name IS NULL OR last_name IS NULL;
ALTER TABLE persons MODIFY first_name VARCHAR(50) NOT NULL;
ALTER TABLE persons MODIFY last_name VARCHAR(50) NOT NULL;

DELETE FROM pets WHERE pet_name IS NULL OR pet_type IS NULL;
ALTER TABLE pets MODIFY pet_name VARCHAR(50) NOT NULL;
ALTER TABLE pets MODIFY pet_type VARCHAR(50) NOT NULL;

ALTER TABLE pets ADD CONSTRAINT unique_pet_per_owner UNIQUE (pet_name, owner_name);

ALTER TABLE persons ADD COLUMN magic_number INT;

UPDATE persons SET magic_number = 7 WHERE age = 18;

UPDATE persons SET magic_number = 20 WHERE age = 18;
UPDATE persons SET magic_number = NULL WHERE age = 28;
UPDATE persons SET magic_number = 50 WHERE id = 25;

UPDATE persons SET major = 'Comp Sci' WHERE LOWER(major) = 'computer science';
UPDATE persons SET major = 'Business Intelligence' WHERE major = 'Business';

UPDATE persons SET magic_number = age + 1 WHERE id % 4 = 0;

SELECT first_name, last_name 
FROM persons 
WHERE major = 'Physics' 
ORDER BY last_name ASC;

SELECT * 
FROM pets 
WHERE LOWER(pet_type) = 'cat' 
ORDER BY pet_name ASC, owner_name ASC;

SELECT * 
FROM pets 
WHERE (owner_id < 10 OR owner_id > 40) 
AND has_fur = TRUE;

DELETE FROM persons 
WHERE first_name = 'Amir' AND last_name = 'Brown';

ALTER TABLE pets DROP FOREIGN KEY fk_pets_owner;

ALTER TABLE pets ADD CONSTRAINT fk_pets_owner_cascade
FOREIGN KEY (owner_id) REFERENCES persons(id) ON DELETE CASCADE;

DELETE FROM persons 
WHERE first_name = 'Amir' AND last_name = 'Brown';






