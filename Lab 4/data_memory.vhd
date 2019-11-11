library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
    port(clk        : in std_logic;
         mem_address : in std_logic_vector(15 downto 0); 
         data_write : in std_logic_vector(15 downto 0);
         mem_write  : in std_logic;
         mem_read   : in std_logic;
         data_read  : out std_logic_vector(15 downto 0));
end data_memory;

architecture simple of data_memory is
    
    type mem_type is array (1 to 256) of std_logic_vector(15 downto 0); -- create a type 'mem type' array that will hold 512 bytes of data_memory
    signal mem_array : mem_type := (others => (others => '0')); -- initialzie array to 0

    begin
        readwrite_proc : process(mem_read, mem_write, clk)
        begin
            if(rising_edge(clk)) then
                if(mem_read = '1') then
                    data_read <= mem_array(to_integer(unsigned(mem_address))); -- read and output data at address
                elsif mem_write = '1' then
		    mem_array(to_integer(unsigned(mem_address))) <= data_write; -- write input data into memory
		end if;
            end if;
        end process readwrite_proc;
end simple;