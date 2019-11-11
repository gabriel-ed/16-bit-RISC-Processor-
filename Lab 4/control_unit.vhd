library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port(opcode :   in std_logic_vector(15 downto 12);
         regDst :   out std_logic;
         jump   :   out std_logic;
         branch :   out std_logic;
         MemRead:   out std_logic;
         Mem_Reg:   out std_logic;
         aluOp  :   out std_logic_vector(2 downto 0);
         MemWrite:  out std_logic;
         aluSrc :   out std_logic;
         regWrite:  out std_logic);
end control_unit;

architecture simple of control_unit is

    begin
        signals : process(opcode)
        begin
            case opcode is
                when "0000" =>  -- add
                    regDst  <= '1';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0';
                when "0001" =>  -- sub
                    regDst  <= '1';
                    aluOp   <= "001"; -- sub
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0';
                when "0010" =>  -- and
                    regDst  <= '1';
                    aluOp   <= "010"; -- and
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0'; 
                when "0011" =>  -- or
                    regDst  <= '1';
                    aluOp   <= "011"; -- or
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0'; 
                when "0100" =>  -- nor
                    regDst  <= '1';
                    aluOp   <= "100"; -- nor
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0';
                when "0101" =>  -- xor
                    regDst  <= '1';
                    aluOp   <= "101"; -- xor
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0';       
                when "0110" =>  -- addi
                    regDst  <= '1';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0';         
                when "0111" =>  -- lb
                    regDst  <= '0';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '1';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '1';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '1';  
                when "1000" =>  -- sb
                    regDst  <= '0';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '1';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '1';
                    regWrite<= '0';
                    Mem_Reg <= '0'; 
                when "1001" =>  -- lw
                    regDst  <= '0';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '1';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '1';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '1';                       
                when "1010" =>  -- sw
                    regDst  <= '0';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '1';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '1';
                    regWrite<= '0';
                    Mem_Reg <= '0';     
                when "1011" =>  -- beq
                    regDst  <= '0';
                    aluOp   <= "001"; -- sub
                    aluSrc  <= '0';
                    branch  <= '1';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '1';
                    regWrite<= '0';
                    Mem_Reg <= '0'; 
                when "1100" =>  -- andi
                    regDst  <= '1';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '0';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0';  
                when "1101" =>  -- J
                    regDst  <= '0';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '1';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '1';
                    Mem_Reg <= '0'; 
                when "1110" =>  -- J
                    regDst  <= '0';
                    aluOp   <= "000"; -- add
                    aluSrc  <= '0';
                    branch  <= '0';
                    jump    <= '1';
                    MemRead <= '0';
                    MemWrite<= '0';
                    regWrite<= '0';
                    Mem_Reg <= '0';                      
                when others =>
           end case;
    end process signals;
end simple;