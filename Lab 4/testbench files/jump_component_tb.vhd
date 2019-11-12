library ieee;
use ieee.std_logic_1164.all;

entity jump_component_tb is
end jump_component_tb;

architecture behavior of jump_component_tb is

    constant max_delay : time := 20 ns;
    constant no_elems : integer := 3;
    type inst_type is array (1 to no_elems) of std_logic_vector(15 downto 0);
    type pc_type is array(1 to no_elems) of std_logic_vector(3 downto 0);
    constant inst_val : inst_type := (x"0298", x"1508", x"2868");
    constant pc_val : pc_type := (x"1", x"2", x"03");
    
    signal instruction_signal, jump_address_signal : std_logic_vector(15 downto 0);
    signal nextpc_sig : std_logic_vector(3 downto 0);
    
    begin
    
    stimulus : process
    begin
        for i in 1 to no_elems loop
            instruction_signal <= inst_val(i);
            nextpc_sig <= pc_val(i);
            wait for max_delay;
        end loop;
    end process stimulus;
    
    DUT:entity work.jump_component
        port map(instruction => instruction_signal, next_pc => nextpc_sig, jump_address => jump_address_signal);
end behavior;
    