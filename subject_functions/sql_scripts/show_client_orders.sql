USE mydb
 
DELIMITER //

DROP PROCEDURE IF EXISTS show_order_client;
CREATE PROCEDURE show_order_client(id_var bigint)
BEGIN
START TRANSACTION;
SELECT orders.begin_date AS orders_begin_date, orders.end_date AS orders_end_date, bank.name AS bank_name, 
payment.sum AS payment_sum, payment.sender_accaunt AS sender_accaunt, payment.recipient_accaunt AS recipient_accaunt,
company.name AS repair_company_name, vehicle.model AS vehicle_model, name.name AS client_name, surname.name AS client_surname, patronymic.name AS client_patronymic
FROM mydb.orders 
 INNER JOIN (SELECT * FROM personal) AS personal
 ON orders.id_client_personal = personal.id
 INNER JOIN (SELECT * FROM payment) AS payment
 ON orders.id_payment = payment.id
 INNER JOIN (SELECT * FROM repair) AS repair
 ON orders.id_repair = repair.id
 INNER JOIN (SELECT * FROM company) AS company
 ON repair.id_company = company.id
 INNER JOIN (SELECT * FROM vehicle) AS vehicle
 ON repair.id_vehicle = vehicle.id
 INNER JOIN (SELECT * FROM bank) AS bank
 ON payment.id_bank = bank.id
 INNER JOIN (SELECT * FROM name) AS name
 ON personal.id_name = name.id
 INNER JOIN (SELECT * FROM surname) AS surname
 ON personal.id_surname = surname.id
 INNER JOIN (SELECT * FROM patronymic) AS patronymic
 ON personal.id_patronymic = patronymic.id
WHERE personal.id = id_var;
COMMIT;
END //
