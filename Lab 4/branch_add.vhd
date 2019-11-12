library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branch_add is
    port (address1 : in std_logic_vector(15 downto 0);
          address2 : in std_logic_vector(15 downto 0);
          output : out std_logic_vector(15 downto 0));
end branch_add;

architecture simple of branch_add is
    signal address_int : integer:= 0;
    begin
        add : process(address1, address2)
        begin
            address_int <= to_integer(unsigned(address1)) + to_integer(unsigned(address2)) ;
        end process add;
        output <= std_logic_vector(to_unsigned(address_int, output'length));
end simple;