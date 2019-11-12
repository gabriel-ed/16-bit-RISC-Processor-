library ieee;
use ieee.std_logic_1164.all;

entity data_memory_tb is
end data_memory_tb;

architecture behavioral of data_memory_tb is

    constant no_elems : integer := 4;
    constant max_delay : time := 20 ns;
    type add_type is array (1 to no_elems) of std_logic_vector(15 downto 0);
    type data_type is array (1 to no_elems) of std_logic_vector(15 downto 0);
    type control_type is array (1 to no_elems) of std_logic;
    constant add_const : add_type := (x"0001", x"0002", x"0001", x"0050");
    constant data_const : data_type := (x"3B1A", x"0369", x"1100", x"F810");
    constant read_const : control_type := ('0','0','1','0');
    constant write_const : control_type := ('1','1','0','1');
    constant ClkFreq : integer := 20e6; --20 MHz
    constant ClkPer  : time := 1000 ms / ClkFreq;
    
    signal clk_sig : std_logic := '0';
    signal read_sig, write_sig : std_logic;
    signal address_sig, data_sig, outdata_sig : std_logic_vector(15 downto 0);
    
    begin
    
        clock : process(clk_sig)
        begin
            clk_sig <= not clk_sig after ClkPer/2;
        end process clock;
        
        stimulus: process
        begin
            for i in 1 to no_elems loop
                read_sig <= read_const(i);
                write_sig <= write_const(i);
                address_sig <= add_const(i);
                data_sig <= data_const(i);
                wait for max_delay;
            end loop;
        end process stimulus;
        
        
        DUT:entity work.data_memory
            port map(clk => clk_sig, mem_address => address_sig, data_write => data_sig, mem_write => write_sig, mem_read => read_sig, data_read => outdata_sig);
end behavioral;