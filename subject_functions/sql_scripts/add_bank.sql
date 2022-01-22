USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS add_bank;
CREATE PROCEDURE add_bank(name_var varchar(80), country_var varchar(45), region_var varchar(45), district_var varchar(45), locality_var varchar(45), 
locality_type_var varchar(45), street_var varchar(45), street_type_var varchar(45))
BEGIN
START TRANSACTION;

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

INSERT INTO address(id_country, id_region, id_district, id_locality, id_locality_type, id_street, id_street_type) 
VALUES (@id_country, @id_region, @id_district, @id_locality, @id_locality_type, @id_street, @id_street_type);
SELECT LAST_INSERT_ID() INTO @id_address;

INSERT INTO bank(id_address, name)
VALUES(@id_address, name_var);

COMMIT;
END //