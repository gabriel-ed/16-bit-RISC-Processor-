library ieee;
use ieee.std_logic_1164.all;

entity clock is
    port(clk    :   out std_logic);
end clock;

architecture simple of clock is 

    constant ClkFreq : integer := 20e6; --20 MHz
    constant ClkPer  : time := 1000ms / ClkFreq;
    
    signal Clk_sig : std_logic := '0';
    begin
        clock : process(Clk_sig)
            begin
                 Clk_sig <= not Clk_sig after ClkPer/2;
        end process clock;
        clk <= Clk_sig;
        

end simple;