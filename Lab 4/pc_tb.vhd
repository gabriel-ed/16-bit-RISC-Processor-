library ieee;
use ieee.std_logic_1164.all;


entity pc_tb is
end pc_tb;

architecture behavior of pc_tb is
	
	constant MAX_DELAY	: time := 20ns;	 -- delay between inputs
	constant NO_ELEMS	: integer := 6;
	type input_value_array is array(1 to NO_ELEMS) of std_logic_vector(15 downto 0);
	constant inst_addr : input_value_array := (x"0000", x"0001", x"0002", x"0003", x"0004", x"0005");
	
	
	signal in1_sig : std_logic_vector(15 downto 0);
	signal out1_sig: std_logic_vector(3 downto 0);
	
	begin
		stimulus: process
		begin
			for i in 1 to NO_ELEMS loop
				in1_sig <= inst_addr(i);
				
				wait for MAX_DELAY;
			end loop;
		end process stimulus;
		
		DUT : entity work.PC
			port map(inst_addr => in1_sig, inst_fetch => out1_sig);
end behavior;