USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS add_order;
CREATE PROCEDURE add_order(days_var smallint, id_var mediumint, sum_var int, sender_accaunt_var varchar(45), recipient_accaunt_var varchar(45), 
bank_name_var varchar(80), repair_company_name_var varchar(50), vehicle_model_var varchar(25))
BEGIN
START TRANSACTION;

SET @id_personal = (SELECT id FROM personal WHERE personal.id = id_var);
SET @personal_dont_exists = IF (@id_personal IS NULL, 1, 0);

SET @id_bank = (SELECT id FROM bank WHERE bank.name = bank_name_var);
SET @bank_dont_exists = IF (@id_bank IS NULL, 1, 0);

SET @id_company = (SELECT id FROM company WHERE company.name = repair_company_name_var);
SET @company_dont_exists = IF (@id_company IS NULL, 1, 0);

SET @id_vehicle = (SELECT id FROM vehicle WHERE vehicle.model = vehicle_model_var);
SET @vehicle_dont_exists = IF (@id_vehicle IS NULL, 1, 0);

SET @rollback_script = IF (@bank_dont_exists OR @company_dont_exists OR @vehicle_dont_exists OR @personal_dont_exists, 'ROLLBACK', 'COMMIT');
PREPARE rollback_statement FROM @rollback_script;

IF NOT @company_dont_exists AND NOT @bank_dont_exists AND NOT @vehicle_dont_exists AND NOT @personal_dont_exists
THEN
INSERT INTO payment
(id_bank, sum, date, sender_accaunt, recipient_accaunt)
SELECT @id_bank, sum_var, CURRENT_TIMESTAMP, sender_accaunt_var, recipient_accaunt_var;
SELECT LAST_INSERT_ID() INTO @id_payment;

INSERT INTO repair
(id_company, id_payment, id_vehicle)
SELECT @id_company, @id_payment, @id_vehicle;
SELECT LAST_INSERT_ID() INTO @id_repair;

INSERT INTO mydb.orders
(id_client_personal, id_payment, id_repair, begin_date, end_date)
SELECT @id_personal, @id_payment, @id_repair, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL days_var DAY;
END IF;

SELECT @company_dont_exists, @bank_dont_exists, @vehicle_dont_exists, @personal_dont_exists;
EXECUTE rollback_statement;

END //
