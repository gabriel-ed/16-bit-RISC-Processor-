library ieee;
use ieee.std_logic_1164.all;

entity sign_extend is
    port (data1 : in std_logic_vector(5 downto 0);
          out_data: out std_logic_vector(15 downto 0));
end sign_extend;

architecture simple of sign_extend is

    begin
    output : process(data1)
        begin
        out_data(5 downto 0) <= data1;
        out_data(15 downto 6) <= (others => '0');
    end process output;
end simple;