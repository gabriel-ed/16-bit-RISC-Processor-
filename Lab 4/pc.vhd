library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(clk    : in std_logic;
         inst_addr:	in std_logic_vector(15 downto 0);
		 inst_fetch	:	out std_logic_vector(3 downto 0));
end PC;

architecture simple of PC is
	signal address_int:std_logic_vector(3 downto 0);
    signal mem_index : integer;
	
	begin
		convert: process(inst_addr,clk)
			begin
			if(rising_edge(clk)) then
                mem_index <= to_integer(unsigned(inst_addr));
            end if;
			
		end process convert;
		inst_fetch <= std_logic_vector(to_unsigned(mem_index, inst_fetch'length));
		  
		 
end simple;
			
			