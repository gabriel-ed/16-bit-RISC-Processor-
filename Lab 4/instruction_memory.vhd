library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is
    port (inst_address : in std_logic_vector(15 downto 0);
             instruction  : out std_logic_vector(15 downto 0));

end instruction_memory;

architecture simple of instruction_memory is
    
    
    type layout_type is array (1 to 15) of std_logic_vector(15 downto 0);
    constant inst_layout: layout_type := (x"0650", x"12A0", x"2B08", x"3358", x"48D0", x"5470", x"6CE0", x"70C8", x"8110", x"9018", x"A190", x"BB60", x"C400", x"D01C", x"E01E");
    constant ClkFreq : integer := 20e6; --100 MHz
    constant ClkPer  : time := 1000ms / ClkFreq;
    signal inst_sig : integer;
    signal Clk : std_logic := '0';
        
    begin
    
        clock : process(Clk)
            begin
                 Clk <= not Clk after ClkPer/2;
        end process clock;
        
    	inst_sig <= to_integer(unsigned(inst_address));
        index : process(inst_sig, clk)
            begin
            if(rising_edge(clk)) then
                instruction <= inst_layout(inst_sig);
            end if;
        end process index;
end simple;