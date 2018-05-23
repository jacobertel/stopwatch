LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY lab345 IS
	PORT (start,stop,reset,clock_50	: IN STD_LOGIC;
			HEX3,HEX2,HEX1,HEX0		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0) );
END lab345;
ARCHITECTURE structure OF lab345 IS
	COMPONENT BCDcount
		PORT(clock,reset,enable	:IN STD_LOGIC;
			 carry				:OUT STD_LOGIC;
			 BCD				:OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	END COMPONENT;
	COMPONENT CLK100Hz
	PORT(clk_in	:IN STD_LOGIC;
		 clk_out:OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT HEXdecoder
		PORT(Digin	:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 Segout	:OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	COMPONENT fsm
		PORT(clock,start,stop,reset	:IN STD_LOGIC;
			 clear,enable		:OUT STD_LOGIC);
	END COMPONENT;
				
SIGNAL clear,enable,clk100	: STD_LOGIC;
SIGNAL carry2,carry1,carry0	: STD_LOGIC;
SIGNAL BCD3,BCD2,BCD1,BCD0	: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	fsm1	: fsm PORT MAP(clock_50,start,stop,reset,clear,enable);

	clkdvd	: clk100Hz PORT MAP(clock_50, clk100);
	
	BCDC0	: BCDcount PORT MAP(clk100,clear,enable,carry0,BCD0);
	BCDC1	: BCDcount PORT MAP(carry0,clear,'1',carry1,BCD1);
	BCDC2	: BCDcount PORT MAP(carry1,clear,'1',carry2,BCD2);
	BCDC3	: BCDcount PORT MAP(carry2,clear,'1',OPEN,BCD3);
	
	HEXD0	: HEXdecoder PORT MAP(BCD0,HEX0);
	HEXD1	: HEXdecoder PORT MAP(BCD1,HEX1);
	HEXD2	: HEXdecoder PORT MAP(BCD2,HEX2);
	HEXD3	: HEXdecoder PORT MAP(BCD3,HEX3);
	
END structure;