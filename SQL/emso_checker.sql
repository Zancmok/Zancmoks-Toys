SET max_sp_recursion_depth = 255;

DROP PROCEDURE IF EXISTS calculate_control_number;
delimiter $$
CREATE PROCEDURE calculate_control_number(IN emso BIGINT, OUT control_number INT)
BEGIN
	DECLARE total_sum INT DEFAULT 0;
	
	DECLARE i INT DEFAULT 0;
	WHILE i < 12
	DO
		SET total_sum = total_sum + (emso DIV POW(10, 12 - i) % 10) * (7 - i % 6);
		
		SET i = i + 1;
	END WHILE;
	
	SET control_number = total_sum % 11;
	
	IF control_number != 0
	THEN
		SET control_number = 11 - control_number;
	END IF;
	
	IF control_number = 10
	THEN
		CALL calculate_control_number(emso + 10, control_number);
	END IF;
END;
$$
delimiter ;

DROP FUNCTION IF EXISTS is_leap_year
delimiter $$
CREATE FUNCTION is_leap_year(leap_year INT)
RETURNS BOOL
BEGIN
	RETURN ((leap_year % 4 = 0) AND (leap_year % 100 != 0)) OR (leap_year % 400 = 0);
END;
$$
delimiter ;

DROP FUNCTION IF EXISTS is_emso_valid;
delimiter $$
CREATE FUNCTION is_emso_valid(emso BIGINT)
RETURNS BOOL
BEGIN
	-- here datum magic
	
	DECLARE control_number INT;
	CALL calculate_control_number(emso, control_number);
	
	RETURN control_number = emso % 10;
END;
$$
delimiter ;

SELECT is_emso_valid(0901007500200);
SELECT is_emso_valid(2905007500394);
