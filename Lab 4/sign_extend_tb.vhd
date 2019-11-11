library ieee;
use ieee.std_logic_1164.all;

entity sign_extend_tb is
end sign_extend_tb;

architecture behavioral of sign_extend_tb is

    constant data1 : std_logic_vector(5 downto 0) := "001011";
    signal data1_sig : std_logic_vector(5 downto 0);
    signal outdata_sig : std_logic_vector(15 downto 0);
    
    begin
        data1_sig <= data1;
        
        
    DUT:entity work.sign_extend
        port map (data1 => data1_sig, out_data => outdata_sig);
end behavioral;