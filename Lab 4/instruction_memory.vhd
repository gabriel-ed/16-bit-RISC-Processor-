library ieee;
use ieee.std_logic_1164.all;

entity instruction_memory is
    port map(inst_address : in std_logic_vector(15 downto 0);
             instruction  : out std_logic_vector(15 downto 0));
end instruction_memory;

architecture behavioral of instruction_memory is
    type layout_type is array (0 to 15) of std_logic_vector(15 downto 0);
    constant inst_layout: layout_type := ("");
    begin
        instruction <= inst_layout(to_integer(unsigned(inst_address)));
end behavioral;