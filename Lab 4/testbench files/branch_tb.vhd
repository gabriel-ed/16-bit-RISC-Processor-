library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branch_tb is
end branch_tb;

architecture behavioral of branch_tb is
    constant no_elems : integer := 2;
    constant max_delay : time := 20 ns;
    type add_type is array (1 to no_elems) of std_logic_vector(15 downto 0);
    constant add1_const : add_type := (x"0868", x"0AC8");
    constant add2_const : add_type := (x"0004", x"0005");
    
    signal add1_sig, add2_sig, outdata_sig : std_logic_vector(15 downto 0);
    
    begin
        stimulus : process
        begin
            for i in 1 to no_elems loop
                add1_sig <= add1_const(i);
                add2_sig <= add2_const(i);
                wait for max_delay;
            end loop;
        end process stimulus;
        
    DUT:entity work.branch_add
        port map(address1 => add1_sig, address2 => add2_sig, output => outdata_sig);
end behavioral;