SET max_sp_recursion_depth = 255;

DROP PROCEDURE IF EXISTS calculate_control_number;
delimiter $$
CREATE PROCEDURE calculate_control_number(INOUT emso INT, OUT control_number INT)
BEGIN
	DECLARE total_sum INT DEFAULT 0;
	
	DECLARE i INT DEFAULT 0;
	WHILE i < 12
	DO
		SET total_sum = total_sum + (emso / POW(10, 12 - i) % POW(10, i)) * ;
		
		SET i = i + 1;
	END WHILE;
END;
$$
delimiter ;

DROP FUNCTION IF EXISTS is_emso_valid;
delimiter $$
CREATE FUNCTION is_emso_valid(emso INT)
RETURNS BOOL
BEGIN
	-- validate date here
	
	
END;
$$
delimiter ;
