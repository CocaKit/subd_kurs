USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS reg_proc;
CREATE PROCEDURE reg_proc(login_var varchar(45), password_var varchar(45), name_var  varchar(45), surname_var  varchar(45), patronymic_var  varchar(45), 
name_latin_var varchar(45), surname_latin_var varchar(45), patronymic_latin_var varchar(45), country_var varchar(45), region_var varchar(45), 
district_var varchar(45), locality_var varchar(45), locality_type_var varchar(45), street_var varchar(45), street_type_var varchar(45), role_var varchar(45), 
phone_number_var varchar(30), card_number_var varchar(30), house_var varchar(10), housing_var varchar(10), flat_var varchar(10), ad_index_var varchar(45))
BEGIN
START TRANSACTION;

SET @login = login_var;
SET @login_duplicates = EXISTS(SELECT login FROM user_info WHERE login = @login);
SET @rollback_script = IF(@login_duplicates, 'ROLLBACK', 'COMMIT');
PREPARE rollback_statement FROM @rollback_script;

SET @id_surname = (SELECT id FROM surname WHERE surname.name = surname_var);
INSERT INTO surname(name) 
 SELECT surname_var
 WHERE @id_surname IS NULL;
SELECT IF(@id_surname IS NULL, LAST_INSERT_ID(), @id_surname)
INTO @id_surname;

SET @id_name = (SELECT id FROM name WHERE name.name = name_var);
INSERT INTO name(name) 
 SELECT name_var
 WHERE @id_name IS NULL;
SELECT IF(@id_name IS NULL, LAST_INSERT_ID(), @id_name)
INTO @id_name;

SET @id_patronymic = (SELECT id FROM patronymic WHERE patronymic.name = patronymic_var);
INSERT INTO patronymic(name) 
 SELECT patronymic_var
 WHERE @id_patronymic IS NULL;
SELECT IF(@id_patronymic IS NULL, LAST_INSERT_ID(), @id_patronymic)
INTO @id_patronymic;

SET @id_surname_latin = (SELECT id FROM surname_latin WHERE surname_latin.name = surname_latin_var);
INSERT INTO surname_latin(name) 
 SELECT surname_latin_var
 WHERE @id_surname_latin IS NULL;
SELECT IF(@id_surname_latin IS NULL, LAST_INSERT_ID(), @id_surname_latin)
INTO @id_surname_latin;

SET @id_name_latin = (SELECT id FROM name_latin WHERE name_latin.name = name_latin_var);
INSERT INTO name_latin(name) 
 SELECT name_latin_var
 WHERE @id_name_latin IS NULL;
SELECT IF(@id_name_latin IS NULL, LAST_INSERT_ID(), @id_name_latin)
INTO @id_name_latin;

SET @id_patronymic_latin = (SELECT id FROM patronymic_latin WHERE patronymic_latin.name = patronymic_latin_var);
INSERT INTO patronymic_latin(name) 
 SELECT patronymic_latin_var
 WHERE @id_patronymic_latin IS NULL;
SELECT IF(@id_patronymic_latin IS NULL, LAST_INSERT_ID(), @id_patronymic_latin)
INTO @id_patronymic_latin;

SET @id_country = (SELECT id FROM country WHERE country.name = country_var);
INSERT INTO country(name) 
 SELECT country_var
 WHERE @id_country IS NULL;
SELECT IF(@id_country IS NULL, LAST_INSERT_ID(), @id_country)
INTO @id_country;

SET @id_region = (SELECT id FROM region WHERE region.name = region_var);
INSERT INTO region(name) 
 SELECT region_var
 WHERE @id_region IS NULL;
SELECT IF(@id_region IS NULL, LAST_INSERT_ID(), @id_region)
INTO @id_region;
 
SET @id_district = (SELECT id FROM district WHERE district.name = district_var);
INSERT INTO district(name) 
 SELECT district_var
 WHERE @id_district IS NULL;
SELECT IF(@id_district IS NULL, LAST_INSERT_ID(), @id_district)
INTO @id_district;
 
SET @id_locality = (SELECT id FROM locality WHERE locality.name = locality_var);
INSERT INTO locality(name) 
 SELECT locality_var
 WHERE @id_locality IS NULL;
SELECT IF(@id_locality IS NULL, LAST_INSERT_ID(), @id_locality)
INTO @id_locality;
 
SET @id_locality_type = (SELECT id FROM locality_type WHERE locality_type.name = locality_type_var);
INSERT INTO locality_type(name) 
 SELECT locality_type_var
 WHERE @id_locality_type IS NULL;
SELECT IF(@id_locality_type IS NULL, LAST_INSERT_ID(), @id_locality_type)
INTO @id_locality_type;

SET @id_street = (SELECT id FROM street WHERE street.name = street_var);
INSERT INTO street(name) 
 SELECT street_var
 WHERE (@id_street IS NULL);
SELECT IF(@id_street IS NULL, LAST_INSERT_ID(), @id_street)
INTO @id_street; 

SET @id_street_type = (SELECT id FROM street_type WHERE street_type.name = street_type_var);
INSERT INTO street_type(name) 
 SELECT street_type_var
 WHERE (@id_street_type IS NULL);
SELECT IF(@id_street_type IS NULL, LAST_INSERT_ID(), @id_street_type)
INTO @id_street_type;

SET @id_role = (SELECT id FROM mydb.role WHERE role.name = role_var);
INSERT INTO mydb.role(name) 
 SELECT role_var
 WHERE (@id_role IS NULL);
SELECT IF(@id_role IS NULL, LAST_INSERT_ID(), @id_role)
INTO @id_role;


INSERT INTO address(id_country, id_region, id_district, id_locality, id_locality_type, id_street, id_street_type, housing, house, flat, ad_index) 
VALUES (@id_country, @id_region, @id_district, @id_locality, @id_locality_type, @id_street, @id_street_type, housing_var, house_var, flat_var, ad_index_var);
SELECT LAST_INSERT_ID() INTO @id_address;

INSERT INTO personal(id_name, id_surname, id_patronymic, id_name_latin, id_surname_latin, id_patronymic_latin, phone_number, card_number) 
 VALUES(@id_name, @id_surname, @id_patronymic, @id_name_latin, @id_surname_latin, @id_patronymic_latin, phone_number_var, card_number_var);
SELECT LAST_INSERT_ID() INTO @id_personal; 

IF @login_duplicates = 0
THEN
INSERT INTO user_info
(login, password_hash, id_role, id_personal, id_address, registration_date, status)
SELECT @login, password_var, @id_role, @id_personal, @id_address, current_timestamp(), 1;
END IF;

SELECT @login_duplicates;
EXECUTE rollback_statement;

END//
