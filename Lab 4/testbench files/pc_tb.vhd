library ieee;
use ieee.std_logic_1164.all;


entity pc_tb is
end pc_tb;

architecture behavior of pc_tb is
	
	constant MAX_DELAY	: time := 20ns;	 -- delay between inputs
	constant NO_ELEMS	: integer := 6;
	type input_value_array is array(1 to NO_ELEMS) of std_logic_vector(15 downto 0);
	constant inst_addr : input_value_array := (x"0000", x"0001", x"0002", x"0003", x"0004", x"0005");
	constant ClkFreq : integer := 20e6; --20 MHz
    constant ClkPer  : time := 1000 ms / ClkFreq;
	
	signal in1_sig : std_logic_vector(15 downto 0);
    signal clk_sig : std_logic:= '0';
	signal out1_sig: std_logic_vector(3 downto 0);
	
	begin
        clock : process(clk_sig)
        begin
            clk_sig <= not clk_sig after ClkPer/2;
        end process clock;
        
		stimulus: process(clk_sig)
        variable i : integer range 1 to no_elems := 1;
            begin
            if(rising_edge(clk_sig)) then
                if( i < 6) then
                    in1_sig <= inst_addr(i);
                    i := i + 1;
                elsif(i = 6) then
                i := 1;
                end if;
            end if;
		end process stimulus;
		
		DUT : entity work.PC
			port map(inst_addr => in1_sig, inst_fetch => out1_sig, clk => clk_sig);
end behavior;