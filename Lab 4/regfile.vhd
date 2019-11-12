library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
    port(clk   :   in std_logic;
         instruction:in std_logic_vector(15 downto 0);
         regDst, regWrite   :in std_logic;
	     data_write:in 	std_logic_vector(15 downto 0);
         read_data1:out std_logic_vector(15 downto 0);
         read_data2:out std_logic_vector(15 downto 0));
end regfile;

architecture simple of regfile is

    
    type reg_type is array (0 to 7) of std_logic_vector(15 downto 0);
    signal reg_arr : reg_type := (x"0001",x"0002",x"0003",x"0004",x"0005",x"0006",x"0007",x"0008");
    signal reg_address: std_logic_vector(2 downto 0);
    begin

        decode : process(clk, regDst, regWrite, reg_address)
            begin
                if rising_edge(clk) then             
                    if regWrite = '1' then
                        reg_arr(to_integer(unsigned(reg_address))) <= data_write;  -- data to get written back to array if regWrite = '1';
                    end if;
		end if;
		if regDst = '1' then
		    reg_address <= instruction(5 downto 3); -- rd index(populate the register array with rd)
		else
                    reg_address <= instruction(8 downto 6); -- rt index(populate the register array with rt)
		end if;
   
	end process decode;
   	read_data1 <= reg_arr(to_integer(unsigned(reg_address)));
	read_data2 <= reg_arr(to_integer(unsigned(instruction(11 downto 9))));  
end simple;
         
         
         