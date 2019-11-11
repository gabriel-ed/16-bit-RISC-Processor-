library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile_tb is
end regfile_tb;

architecture behavioral of regfile_tb is

    type control_sig is array (1 to 4) of std_logic;
    type instruction_field is array (1 to 4) of std_logic_vector(15 downto 0);
    constant instruction_const : instruction_field := (x"0298", x"1508", x"2868", x"3AC8");
    constant regDst_const : control_sig := ('0','0','0','0');
    constant regWrite_const : control_sig := ('0','0','0','1');
    constant NO_ELEMS : integer := 4;
    constant MAX_DELAY : time := 50 ns;
    constant ClkFreq : integer := 20e6; --20 MHz
    constant ClkPer  : time := 1000 ms / ClkFreq;
    
    signal instruction_sig, read_data1_sig, read_data2_sig : std_logic_vector(15 downto 0);
    signal regDst_sig, regWrite_sig : std_logic;
    signal clk_sig : std_logic := '0';
    
    begin
    
        clocked : process(clk_sig)
        begin
            clk_sig <= NOT clk_sig after ClkPer/2;
        end process clocked;
        
        stimulus : process
        begin
            for i in 1 to NO_ELEMS loop
                instruction_sig <= instruction_const(i);
                regDst_sig <= regDst_const(i);
                regWrite_sig <= regWrite_const(i);
                wait for MAX_DELAY;
            end loop;
        end process stimulus;
        
        DUT:entity work.regfile
            port map(clk => clk_sig, instruction => instruction_sig, regDst => regDst_sig, regWrite => regWrite_sig, read_data1 => read_data1_sig, read_data2 => read_data2_sig);
end behavioral;
