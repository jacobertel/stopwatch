LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY BCDcountenable IS
	PORT (	clock,reset,enable	: IN 		STD_LOGIC ;
			carry				: OUT		STD_LOGIC ;
			BCD0				: BUFFER 	STD_LOGIC_VECTOR(3 DOWNTO 0) ) ;
END BCDcountenable ;

ARCHITECTURE Behavior OF BCDcountenable IS
BEGIN
	PROCESS ( clock )
	BEGIN
		IF (clock'EVENT AND clock = '1') THEN
			IF Reset = '1' THEN
				BCD0 <= "0000" ;
			ELSIF E = '1' THEN
				IF BCD0 = "1001" THEN
					BCD0 <= "0000" ;
					Carry <= '1';
				ELSE
					BCD0 <= BCD0 + '1';
					carry <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
END Behavior ;
