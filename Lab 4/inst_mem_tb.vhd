library ieee;
use ieee.std_logic_1164.all;

entity inst_mem_tb is
end inst_mem_tb;

architecture behavior of inst_mem_tb is
    constant MAX_DELAY : time := 100 ns;
    constant NO_ELEMS : integer := 15;

    type pc_arr is array (1 to NO_ELEMS) of std_logic_vector(15 downto 0);
    constant pc_array : pc_arr := (x"0001", x"0002", x"0003", x"0004", x"0005", x"0006", x"0007", x"0008", x"0009", x"000A", x"000B", x"000C", x"000D", x"000E", x"000F");
    --constant pc_array : pc_arr := (15,14,13,12,11,10,9,8,7,6,5,4,3,2,1);
   
    signal pc_sig : std_logic_vector(15 downto 0);
    signal instruction_sig : std_logic_vector(15 downto 0);
    
    begin
        stimulus : process
        begin  
            for i in 1 to NO_ELEMS loop
                pc_sig <= pc_array(i);
                wait for MAX_DELAY;
            end loop;
        end process stimulus;
        
        DUT: entity work.instruction_memory
            port map(inst_address => pc_sig, instruction => instruction_sig);
end behavior;
		
				
		
		