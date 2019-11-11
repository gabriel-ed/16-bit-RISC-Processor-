library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end control_unit_tb;

architecture behavioral of control_unit_tb is
    constant NO_ELEMS : integer := 15;
    constant max_delay : time := 20 ns;
    type op_type is array (1 to NO_ELEMS) of std_logic_vector(3 downto 0);
    constant op_arr : op_type := (x"0",x"1",x"2",x"3",x"4",x"5",x"6",x"7",x"8",x"9",x"A",x"B",x"C",x"D",x"E");
    
    signal op_sig : std_logic_vector(3 downto 0);
    signal regDst_sig, jump_sig, branch_sig, Memread_sig, MemReg_sig, MemWrite_sig, aluSrc_sig, regWrite_sig : std_logic;
    signal aluOp_sig : std_logic_vector(2 downto 0);
    
    begin
        stimulus : process
        begin
            for i in 1 to NO_ELEMS loop
                op_sig <= op_arr(i);
                wait for max_delay;
            end loop;
        end process stimulus;
        
        DUT:entity work.control_unit
            port map(opcode => op_sig, regDst => regDst_sig, jump => jump_sig, branch => branch_sig, Memread => Memread_sig, Mem_Reg => MemReg_sig, aluOp => aluOp_sig, MemWrite => MemWrite_sig, aluSrc => aluSrc_sig, regWrite => regWrite_sig);  
end behavioral;