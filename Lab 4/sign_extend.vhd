library ieee;
use ieee.std_logic_1164.all;

entity sign_extend is
    port (data1 : in std_logic_vector(11 downto 0); -- address 12 bits
          out_data: out std_logic_vector(15 downto 0)); -- output 16 bits
end sign_extend;

architecture simple of sign_extend is

    begin
    output : process(data1)
        begin
        out_data(11 downto 0) <= data1; -- copy address into bottom 12 bits of out_data
        out_data(15 downto 12) <= (others => '0'); -- pad upper 4 bits with 0
    end process output;
end simple;