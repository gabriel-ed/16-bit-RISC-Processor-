library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture behavioral of alu_tb is

	constant max_delay : time := 20 ns;
	constant no_elems  : integer := 9;
    constant alu_elems : integer := 9;
	type input_value_array is array (1 to no_elems) of std_logic_vector(15 downto 0);
	type aluop_array is array (1 to alu_elems) of std_logic_vector(3 downto 0);
	constant data1_vals: input_value_array := ("0000000001001100", "0000000101000000", "0000000001001100", "0000000101000000","0000000001001100", "0000000101000000", "0000000001001100", "0000000101000000", x"0000");
	constant data2_vals: input_value_array := ("0000000000001111", "0000000001000000", "0000000000001111", "0000000001000000","0000000000001111", "0000000001000000", "0000000000001111", "0000000001000000", x"0000");
	constant aluop : aluop_array := ("0000","0000","0001", "0001", "0010", "0010", "0011", "0011", "0000");
    
    
    signal data1_sig, data2_sig : std_logic_vector(15 downto 0);
    signal aluop_sig : std_logic_vector(3 downto 0);
    signal zero_sig : std_logic;
    signal result_sig : std_logic_vector(15 downto 0);
    
	begin
		stimulus : process
        begin
            for i in 1 to no_elems loop
                data1_sig <= data1_vals(i);
                data2_sig <= data2_vals(i);
                aluop_sig <= aluop(i);
                wait for max_delay;
            end loop;
        end process stimulus;
        
        DUT: entity work.ALU
            port map(data1 => data1_sig, data2 => data2_sig, aluop => aluop_sig, zero => zero_sig, result => result_sig);
end behavioral;
		