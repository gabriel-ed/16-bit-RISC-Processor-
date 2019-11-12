library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end processor_tb;

architecture behavior of processor_tb is

    signal clock : std_logic:= '0';
    signal pc_sig   : std_logic_vector(15 downto 0);
    signal count : integer := 0;
    signal flush : integer := 0;
    constant no_instructions : integer := 15;
    constant ClkFreq : integer := 100e6; --20 MHz
    constant ClkPer  : time := 1000 ms / ClkFreq;
    type instruct_type is array (0 to 14) of std_logic_vector(15 downto 0);
    constant instruction_index : instruct_type := (x"0001", x"0002", x"0003", x"0004", x"0005", x"0006", x"0007", x"0008", x"0009", x"000A", x"000B", x"000C", x"000D", x"000E", x"000F");
        
    begin
            
        stimulus : process(clock)
        begin
            clock <= NOT clock after ClkPer/2;
        end process stimulus;
	
	flush_count : process(clock)
	begin
	    if(rising_edge(clock)) then
		flush <= flush+1;
		if flush = 10 then
		    flush <= 0;
		else
		    flush <= flush + 1;
		end if;
	    end if;
	end process flush_count;
        
        instruction : process(clock ,flush)
        begin
            if rising_edge(clock) then
		if flush = 10 then
                	pc_sig <= instruction_index(count);
			count <= count + 1;
	    	elsif(count = no_instructions-1) then
			count <= 0;
            	end if;
	    end if;

        end process instruction;
    DUT:entity work.top_level
        port map (clk => clock, pc2 => pc_sig);

end behavior;