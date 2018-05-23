LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY BCDcount IS
	PORT (	Clock 		: IN 		STD_LOGIC ;
			Reset		: IN 		STD_LOGIC ;
			Enable		: IN 		STD_LOGIC ;
			Carry		: OUT		STD_LOGIC ;
			BCD			: OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0) ) ;
END BCDcount ;

ARCHITECTURE Behavior OF BCDcount IS
	signal count: std_logic_vector(3 downto 0);
BEGIN
	PROCESS (Reset, Clock )
	BEGIN
		IF Reset = '1' THEN
			count <= "0000";
			Carry <= '0';
		ELSIF Clock'EVENT AND Clock = '1' THEN
			IF Enable = '1' THEN
				IF count = "1001" THEN
					count <= "0000";
					Carry <= '1';
				ELSE
					count <= count+1;
					Carry <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
	BCD<=count;
END Behavior ;