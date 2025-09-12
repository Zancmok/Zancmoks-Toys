SET max_sp_recursion_depth = 255;

DROP PROCEDURE IF EXISTS fibonacci;
delimiter $$
CREATE PROCEDURE fibonacci(INOUT element_id INT, INOUT a INT, INOUT b INT, OUT output INT)
BEGIN
	DECLARE c INT;

	IF element_id = 0
	THEN
		SET output = a + b;
	ELSE
		SET element_id = element_id - 1;
		
		SET c = a + b;
		SET a = b;
		SET b = c;
		
		CALL fibonacci(element_id, a, b, output);
	END IF;
END;
$$
delimiter ;

DROP FUNCTION IF EXISTS fibonacci;
delimiter $$
CREATE FUNCTION fibonacci(element_id INT)
RETURNS INT
BEGIN
	DECLARE output INT;
	DECLARE a INT DEFAULT 0;
	DECLARE b INT DEFAULT 1;
	
	SET element_id = element_id - 2;
	
	IF element_id = -2
	THEN
		RETURN a;
	END IF;
	
	IF element_id = -1
	THEN
		RETURN b;
	END IF;
	
	CALL fibonacci(element_id, a, b, output);
	
	RETURN output;
END;
$$
delimiter ;

SELECT fibonacci(25);
