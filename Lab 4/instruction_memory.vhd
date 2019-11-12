library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is
    port (clk          : in std_logic;
          inst_address : in std_logic_vector(15 downto 0);
          instruction  : out std_logic_vector(15 downto 0));

end instruction_memory;

architecture simple of instruction_memory is

    type layout_type is array (0 to 14) of std_logic_vector(15 downto 0);
    constant inst_layout: layout_type := (x"0298", x"1508", x"2868", x"3AC8", x"42A0", x"5710", x"6CE0", x"7043", x"8084", x"90C0", x"A086", x"BB46", x"C65D", x"D01C", x"E01E");
    signal inst_sig : integer;
    begin
    
    	inst_sig <= to_integer(unsigned(inst_address));
        index : process(inst_sig, clk)
            begin
            if(rising_edge(clk)) then
                instruction <= inst_layout(inst_sig);
            end if;
        end process index;
end simple;