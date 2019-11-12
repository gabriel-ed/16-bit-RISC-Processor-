library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_add is
    port (address : in std_logic_vector(15 downto 0);
          output : out std_logic_vector(15 downto 0));
end pc_add;

architecture simple of pc_add is
    signal data2_temp : std_logic_vector(15 downto 0) := x"0002";
    begin
        add : process(address)
        begin
            output <= address + x"0002";
        end process add;
end simple;