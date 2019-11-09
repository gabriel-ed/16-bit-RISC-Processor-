library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(data1	:	in std_logic_vector(15 downto 0);
		 data2	:	in std_logic_vector(15 downto 0);
		 aluop	:	in std_logic_vector(3 downto 0); 
		 zero	:	out std_logic;
		 result	:	out std_logic_vector(15 downto 0));
end ALU;

architecture simple of ALU is
	signal int_addu: unsigned(15 downto 0);
	signal int_add : signed(15 downto 0);
    signal data1_temp: std_logic_vector(15 downto 0);
	signal data2_temp: std_logic_vector(15 downto 0);
    signal res_temp : std_logic_vector(15 downto 0);

	begin
	
    
	operation:process(aluop, int_add, int_addu, data1, data2)

		begin
		case aluop is
			when "0000" => -- add (unsigned)
				int_addu <= unsigned(data1) + unsigned(data2);
				res_temp <= std_logic_vector(unsigned(data1) + unsigned(data2));

			when "0001" => -- add (signed)
				data2_temp <= std_logic_vector(NOT unsigned(data2) + "0000000000000001");
				int_add <= signed(data1) + signed(data2_temp);
				res_temp <= std_logic_vector(int_add);	

            when "0010" => -- and 
                res_temp <= data1 and data2;
            
            when "0011" => -- or
                res_temp <= data1 or data2;
                
			when others =>        
                res_temp <= "XXXXXXXXXXXXXXXX";
		end case;
	end process operation;
    
    zero_proc:process(res_temp, data1, data2)
        begin
            if(res_temp  = "0000000000000000") then
                zero <= '1';
            else
                zero <= '0';
            end if;
                
    end process zero_proc;
    result <= res_temp;
end simple;