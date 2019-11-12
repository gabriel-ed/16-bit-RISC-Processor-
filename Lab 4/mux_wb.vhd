library ieee;
use ieee.std_logic_1164.all;

entity mux_wb is
    port(data1  : in std_logic_vector(15 downto 0);
         data2  : in std_logic_vector(15 downto 0);
         sel    : in std_logic;
         output : out std_logic_vector(15 downto 0));
end mux_wb;

architecture simple of mux_wb is

    begin
        sel_process : process(sel, data1, data2)
        begin   
            if sel = '0' then
                output <= data1;
            else
                output <= data2;
            end if;
        end process sel_process;
end simple;
