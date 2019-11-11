library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_control is
    port(aluOp  :   in std_logic_vector(2 downto 0);
         aluFunc:   in std_logic_vector(2 downto 0); -- arbitrary (all func bits are '000')
         aluCont:   out std_logic_vector(2 downto 0));
end alu_control;

architecture simple of alu_control is
    signal alu_operation : std_logic_vector(2 downto 0);
    
    
    begin
        alu_operation <= aluOp;
        pass : process(alu_operation)
        begin
            aluCont <= alu_operation;
        end process pass;
        
end simple;