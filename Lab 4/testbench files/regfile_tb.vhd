library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile_tb is
end regfile_tb;

architecture behavioral of regfile_tb is

    type control_sig is array (1 to 4) of std_logic;
    type instruction_field is array (1 to 4) of std_logic_vector(15 downto 0);
    constant instruction_const : std_logic_vector(15 downto 0) := (x"7043");
    constant regDst_const : control_sig := ('0','0','0','0');
    constant regWrite_const : control_sig := ('1','1','1','1');
    constant data_write_const : std_logic_vector(15 downto 0) := x"4AB2";
    constant NO_ELEMS : integer := 4;
    constant MAX_DELAY : time := 50 ns;
    constant ClkFreq : integer := 20e6; --20 MHz
    constant ClkPer  : time := 1000 ms / ClkFreq;
    
    signal instruction_sig, read_data1_sig, read_data2_sig : std_logic_vector(15 downto 0);
    signal regDst_sig, regWrite_sig : std_logic;
    signal clk_sig : std_logic := '1';
    signal count : integer range 1 to no_elems:= 1;    
    signal data_write_sig   : std_logic_vector(15 downto 0);
    

    begin
    
        clocked : process(clk_sig)
        begin
            clk_sig <= NOT clk_sig after ClkPer/2;
        end process clocked;
        
        stimulus : process(clk_sig,count)
        begin
	if(rising_edge(clk_sig)) then
		if(count < 4) then
			data_write_sig <= data_write_const;
                	instruction_sig <= instruction_const;
                	regDst_sig <= regDst_const(count);
                	regWrite_sig <= regWrite_const(count);
			count <= count + 1;
		elsif count = 4 then
			count <= 1;
		end if;
	end if;
        end process stimulus;
        
        DUT:entity work.regfile
            port map(clk => clk_sig, instruction => instruction_sig, regDst => regDst_sig, regWrite => regWrite_sig, data_write => data_write_sig, read_data1 => read_data1_sig, read_data2 => read_data2_sig);
end behavioral;
