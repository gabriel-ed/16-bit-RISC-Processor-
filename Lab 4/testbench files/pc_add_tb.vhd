library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_add_tb is
end pc_add_tb;

architecture behavioral of pc_add_tb is
    constant no_elems : integer := 4;
    constant max_delay : time := 20 ns;
    type add_type is array (1 to no_elems) of std_logic_vector(15 downto 0);
    constant add_const : add_type := (x"0001", x"0002", x"0003", x"0004");
    
    signal data1_sig, outdata_sig : std_logic_vector(15 downto 0);
    
    begin
        stimulus : process
        begin
            for i in 1 to no_elems loop
                data1_sig <= add_const(i);
                wait for max_delay;
            end loop;
        end process stimulus;
        
    DUT:entity work.pc_add
        port map(address => data1_sig, output => outdata_sig);
end behavioral;