USE mydb
 
DELIMITER //

DROP PROCEDURE IF EXISTS show_client_role;
CREATE PROCEDURE show_client_role(login_var varchar(45))
BEGIN
START TRANSACTION;
SELECT id_role
FROM user_info
WHERE login = login_var;
COMMIT;
END //
