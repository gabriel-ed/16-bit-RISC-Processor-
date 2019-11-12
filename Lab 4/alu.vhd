library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(data1	:	in std_logic_vector(15 downto 0);
		 data2	:	in std_logic_vector(15 downto 0);
		 aluop	:	in std_logic_vector(2 downto 0); 
		 zero	:	out std_logic;
		 result	:	out std_logic_vector(15 downto 0));
end ALU;

architecture simple of ALU is
	signal int_addu: unsigned(15 downto 0);
	signal int_sub : integer ;
    signal data1_temp: std_logic_vector(15 downto 0);
	signal data2_temp: std_logic_vector(15 downto 0);
    signal res_temp : std_logic_vector(15 downto 0);

	begin
	
    
	operation:process(aluop,data1, data2, int_addu, int_sub, res_temp)
		begin
            case aluop is
                when "000" => -- add (unsigned)
                    int_addu <= unsigned(data1) + unsigned(data2);
                    res_temp <= std_logic_vector(unsigned(data1) + unsigned(data2));

                when "001" => -- add (signed)
		    int_sub <= to_integer(unsigned(data1)) - to_integer(unsigned(data2));
		    res_temp <= std_logic_vector(to_unsigned(int_sub, res_temp'length));

                when "010" => -- and 
                    res_temp <= data1 and data2;
                
                when "011" => -- or
                    res_temp <= data1 or data2;
                
                when "100" => -- nor
                    res_temp <= data1 NOR data2;
                    
                when "101" => -- xor
                    res_temp <= data1 XOR data2;
                when others =>        
                    res_temp <= "XXXXXXXXXXXXXXXX";
            end case;
            if(res_temp  = "0000000000000000") then
                zero <= '1';
            else
                zero <= '0';
            end if;

	end process operation;
	result <= res_temp;
end simple;