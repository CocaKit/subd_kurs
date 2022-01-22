USE mydb
 
DELIMITER //

CREATE PROCEDURE search_user_proc(login_var varchar(45), name_var  varchar(45), surname_var  varchar(45), patronymic_var  varchar(45), 
name_latin_var varchar(45), surname_latin_var varchar(45), patronymic_latin_var varchar(45), country_var varchar(45), region_var varchar(45), 
district_var varchar(45), locality_var varchar(45), locality_type_var varchar(45), street_var varchar(45), street_type_var varchar(45), 
role_var varchar(45), house_var char(3), housing_var char(2), flat_var char(3), ad_index_var varchar(45), card_number_var varchar(45), phone_number_var varchar(45))
BEGIN

SELECT login, name.name AS name, surname.name AS surname, patronymic.name AS patronymic, name_latin.name AS name_latin, surname_latin.name AS surname_latin, 
patronymic_latin.name AS patronymic_latin, role.name AS role, p.phone_number AS phone_number, p.card_number AS card_number,
country.name AS country, district.name AS district, region.name AS region, locality_type.name AS locality_type, locality.name AS locality,
street_type.name AS street_type, street.name AS street, a.housing AS housing, a.house AS house, a.flat AS flat, a.ad_index AS address_index
FROM user_info 
 INNER JOIN (SELECT * FROM personal) as p
 ON user_info.id_personal = p.id 
 INNER JOIN (SELECT * FROM address) as a
 ON user_info.id_address = a.id 
 INNER JOIN (SELECT * FROM name) as name
 ON p.id_name = name.id 
 INNER JOIN (SELECT * FROM surname) as surname
 ON p.id_surname = surname.id 
 INNER JOIN (SELECT * FROM patronymic) as patronymic
 ON p.id_patronymic = patronymic.id 
 INNER JOIN (SELECT * FROM name_latin) as name_latin
 ON p.id_name_latin = name_latin.id 
 INNER JOIN (SELECT * FROM surname_latin) as surname_latin
 ON p.id_surname_latin = surname_latin.id 
 INNER JOIN (SELECT * FROM patronymic_latin) as patronymic_latin
 ON p.id_patronymic_latin = patronymic_latin.id
 INNER JOIN (SELECT * FROM role) as role
 ON user_info.id_role = role.id 
 INNER JOIN (SELECT * FROM country) as country
 ON a.id_country = country.id
 INNER JOIN (SELECT * FROM district) as district
 ON a.id_district = district.id
 INNER JOIN (SELECT * FROM region) as region
 ON a.id_region = region.id
 INNER JOIN (SELECT * FROM locality_type) as locality_type
 ON a.id_locality_type = locality_type.id
 INNER JOIN (SELECT * FROM locality) as locality
 ON a.id_locality= locality.id
 INNER JOIN (SELECT * FROM street_type) as street_type
 ON a.id_street_type= street_type.id
 INNER JOIN (SELECT * FROM street) as street
 ON a.id_street= street.id
WHERE COALESCE(login, '') LIKE CONCAT('%',login_var,'%')
 AND COALESCE(name.name, '') LIKE CONCAT('%',name_var,'%')
 AND COALESCE(surname.name, '') LIKE CONCAT('%',surname_var,'%')
 AND COALESCE(patronymic.name, '') LIKE CONCAT('%',patronymic_var,'%')
 AND COALESCE(name_latin.name, '') LIKE CONCAT('%',name_latin_var,'%')
 AND COALESCE(surname_latin.name, '') LIKE CONCAT('%',surname_latin_var,'%')
 AND COALESCE(patronymic_latin.name, '') LIKE CONCAT('%',patronymic_latin_var,'%')
 AND COALESCE(role.name, '') LIKE CONCAT('%',role_var,'%')
 AND COALESCE(p.phone_number, '') LIKE CONCAT('%',phone_number_var,'%')
 AND COALESCE(p.card_number, '') LIKE CONCAT('%',card_number_var,'%')
 AND COALESCE(country.name, '') LIKE CONCAT('%',country_var,'%')
 AND COALESCE(district.name, '') LIKE CONCAT('%',district_var,'%')
 AND COALESCE(region.name, '') LIKE CONCAT('%',region_var,'%')
 AND COALESCE(locality_type.name, '') LIKE CONCAT('%',locality_type_var,'%')
 AND COALESCE(locality.name, '') LIKE CONCAT('%',locality_var,'%')
 AND COALESCE(street_type.name, '') LIKE CONCAT('%',street_type_var,'%')
 AND COALESCE(street.name, '') LIKE CONCAT('%',street_var,'%')
 AND COALESCE(a.housing, '') LIKE CONCAT('%',housing_var,'%')
 AND COALESCE(a.flat,'') LIKE CONCAT('%',flat_var,'%')
 AND COALESCE(a.ad_index,'') LIKE CONCAT('%',ad_index_var,'%');
END //
