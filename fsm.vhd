LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY fsm IS
	PORT(clock,start,stop,reset	:IN STD_LOGIC;
		 clear,enable			:OUT STD_LOGIC);
END fsm;

ARCHITECTURE Behavior OF FSM IS
	TYPE state_type IS (nocount,nocountreset,count,countreset);
	SIGNAL y: state_type;
BEGIN
	PROCESS(clock)
	BEGIN
		IF(clock'EVENT AND clock='1') THEN
			CASE y IS
				WHEN nocount=>
					IF reset='0' THEN
						y<=nocountreset;
					ELSIF start='0' THEN
						y<=count;
					ELSE
						y<=nocount;
					END IF;
				WHEN nocountreset=>
					IF reset='1' THEN
						y<=nocount;
					ELSE
						y<=nocountreset;
					END IF;
				WHEN count=>
					IF reset='0' THEN
						y<=countreset;
					ELSIF stop='0' THEN
						y<=nocount;
					ELSE
						y<=count;
					END IF;
				WHEN countreset=>
					IF reset='1' THEN
						y<=count;
					ELSE
						y<=countreset;
					END IF;
			END CASE;
		END IF;
	END PROCESS;
	WITH y SELECT
		clear<= '0' WHEN nocount,
				'1' WHEN nocountreset,
				'0' WHEN count,
				'1' WHEN countreset,
				'0' WHEN OTHERS;
	WITH y SELECT
		enable<='0' WHEN nocount,
				'0' WHEN nocountreset,
				'1' WHEN count,
				'1' WHEN OTHERS;
end Behavior;
