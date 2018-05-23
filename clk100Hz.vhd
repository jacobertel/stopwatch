library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk100Hz is
    Port (
        clk_in : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end clk100Hz;

architecture Behavioral of clk100Hz is
    signal temporal: STD_LOGIC;
    signal counter : integer range 0 to 249999 := 0;
begin
    frequency_divider: process (clk_in) begin
        if (clk_in'event and clk_in = '1') then
            if (counter = 249999) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_out <= temporal;
end Behavioral;