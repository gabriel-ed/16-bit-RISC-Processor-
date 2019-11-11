library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture behavioral of alu_tb is

	constant max_delay : time := 20 ns;
	constant no_elems  : integer := 6;
    constant alu_elems : integer := 6;
	type input_value_array is array (1 to no_elems) of std_logic_vector(15 downto 0);
	type aluop_array is array (1 to alu_elems) of std_logic_vector(2 downto 0);
	constant data1_vals: std_logic_vector(15 downto 0) := (x"00B5");
	constant data2_vals: std_logic_vector(15 downto 0) := (x"00B5");
	constant aluop : aluop_array := ("000","001", "010", "011", "100", "101");  
    
    signal data1_sig, data2_sig : std_logic_vector(15 downto 0);
    signal aluop_sig : std_logic_vector(2 downto 0);
    signal zero_sig : std_logic;     
    signal result_sig : std_logic_vector(15 downto 0);
    
	begin
            
	stimulus : process
        begin
            for i in 1 to no_elems loop
                data1_sig <= data1_vals;
                data2_sig <= data2_vals;
                aluop_sig <= aluop(i);
                wait for max_delay/2;
            end loop;
        end process stimulus;
        
        DUT: entity work.ALU
            port map(data1 => data1_sig, data2 => data2_sig, aluop => aluop_sig, zero => zero_sig, result => result_sig);
end behavioral;
		