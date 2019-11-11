library ieee;
use ieee.std_logic_1164.all;

entity clock_tb is
end clock_tb;

architecture behavioral of clock_tb is

    signal clk_sig : std_logic;
    
    
    begin
        stimulus : process
	begin
		clk_sig <= '0';
	end process stimulus;
            

    DUT: entity work.clock
        port map(clk => clk_sig);
end behavioral;    