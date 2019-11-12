library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_add is
    port (address : in std_logic_vector(15 downto 0);
          output : out std_logic_vector(15 downto 0));
end pc_add;

architecture simple of pc_add is
    signal address_int : integer := 0;
    begin
        add : process(address)
        begin
            address_int <= to_integer(unsigned(address)) + 1;
        end process add;
        output <= std_logic_vector(to_unsigned(address_int, output'length));
end simple;