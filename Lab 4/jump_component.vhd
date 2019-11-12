library ieee;
use ieee.std_logic_1164.all;

entity jump_component is
    port(instruction : in std_logic_vector(15 downto 0);
         next_pc : in std_logic_vector(3 downto 0);
         jump_address : out std_logic_vector(15 downto 0));
end jump_component;

architecture simple of jump_component is
    begin
        output : process(instruction, next_pc)
        begin
            jump_address(11 downto 0) <= instruction(11 downto 0);
            jump_address(15 downto 12) <= next_pc;
        end process output;
        
end simple;