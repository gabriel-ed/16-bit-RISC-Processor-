library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
    port(clk   :   in std_logic;
         instruction:in std_logic_vector(15 downto 0);
         regDst, regWrite   :in std_logic;
         read_data1:out std_logic_vector(15 downto 0);
         read_data2:out std_logic_vector(15 downto 0));
end regfile;

architecture simple of regfile is

    
    signal clock_sig : std_logic;
    type reg_type is array (0 to 7) of std_logic_vector(15 downto 0);
    signal reg_arr : reg_type := (x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000");
    signal wb_data : std_logic_vector(15 downto 0); -- write back from memory or ALU operation
    signal read_reg1 : std_logic_vector(2 downto 0);
    signal read_reg2 : std_logic_vector(2 downto 0);
    signal reg_address: std_logic_vector(2 downto 0);
    begin

        decode : process(clk, regDst, regWrite)
            begin
                if rising_edge(clk) then             
                    if regWrite = '1' then
                        reg_arr(to_integer(unsigned(reg_address))) <= wb_data;  -- data to get written back to array if regWrite = '1';
                    else
                        if regDst = '1' then 
                            reg_address <= instruction(5 downto 3); -- rd index(populate the register array with rd)
                        else
                            reg_address <= instruction(8 downto 6); -- rt index(populate the register array with rt)
                        end if;
                        read_reg1 <= instruction(11 downto 9); -- rs (address in register array) index for reading
                        read_reg2 <= instruction(8 downto 6);  -- rt (address in register array) index for reading    
                        -- read from register array
                        read_data1 <= reg_arr(to_integer(unsigned(read_reg1)));
                        read_data2 <= reg_arr(to_integer(unsigned(read_reg2)));                        
                    end if;
                
                   
                

                    
                end if;
                
        end process decode;
        
end simple;
         
         
         