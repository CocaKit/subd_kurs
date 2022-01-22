#!/bin/bash
mysql -u root -e "select personal.id, name.name, surname.name AS surname, patronymic.name AS patronymic from personal 
INNER JOIN (SELECT * FROM name) AS name
ON personal.id_name = name.id
INNER JOIN (SELECT * FROM surname) AS surname
ON personal.id_surname = surname.id
INNER JOIN (SELECT * FROM patronymic) AS patronymic
ON personal.id_patronymic = patronymic.id;" mydb 
