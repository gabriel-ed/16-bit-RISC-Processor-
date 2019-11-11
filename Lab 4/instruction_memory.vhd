library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is
    port (inst_address : in std_logic_vector(15 downto 0);
             instruction  : out std_logic_vector(15 downto 0));

end instruction_memory;

architecture simple of instruction_memory is
 
    COMPONENT clock_component IS
		PORT(clk : OUT std_logic);
	END COMPONENT;
    
	FOR ALL : clock_component USE ENTITY work.clock(simple);    
    
    type layout_type is array (1 to 15) of std_logic_vector(15 downto 0);
    constant inst_layout: layout_type := (x"0298", x"1508", x"2868", x"3AC8", x"42A0", x"5710", x"6CE0", x"7043", x"8084", x"90C0", x"A086", x"BB46", x"C65D", x"D01C", x"E01E");
    constant ClkFreq : integer := 20e6; --100 MHz
    constant ClkPer  : time := 1000ms / ClkFreq;
    signal inst_sig : integer;
    signal clock_sig : std_logic;
    begin
    
	CLOCK : clock_component PORT MAP(clk => clock_sig);
        
    	inst_sig <= to_integer(unsigned(inst_address));
        index : process(inst_sig, clock_sig)
            begin
            if(rising_edge(clock_sig)) then
                instruction <= inst_layout(inst_sig);
            end if;
        end process index;
end simple;