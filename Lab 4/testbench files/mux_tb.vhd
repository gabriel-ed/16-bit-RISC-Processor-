library ieee;
use ieee.std_logic_1164.all;

entity mux_tb is
end mux_tb;

architecture behavioral of mux_tb is
    
    constant no_elems : integer := 2;
    constant max_delay : time := 20 ns;
    
    type sel_line is array (1 to no_elems) of std_logic;
    constant sel_val : sel_line := ('0', '1');
    constant data1_val : std_logic_vector(15 downto 0) := x"36A9";
    constant data2_val : std_logic_vector(15 downto 0) := x"00B4";
    
    signal sel_sig : std_logic;
    signal data1_sig, data2_sig, out_sig : std_logic_vector(15 downto 0);
    
    begin
    
        stimulus : process
        begin   
            for i in 1 to no_elems loop
                sel_sig <= sel_val(i);
                data1_sig <= data1_val;
                data2_sig <= data2_val;
                wait for max_delay;
            end loop;
        end process stimulus;
        
    
        DUT:entity work.mux
            port map(data1 => data1_sig, data2 => data2_sig, sel => sel_sig, output => out_sig);
end behavioral;

                
        
    
