library ieee;
use ieee.std_logic_1164.all;

entity add_op is
	port(data1	:	in std_logic;
		 data2	:	in std_logic;
		 c_in	:	in std_logic;
		 c_out	:	out std_logic;
		 sum	:	out std_logic));
end add_op;

architecture simple of add_op is
	signal imm1, imm2, imm3 : std_logic;
	begin
		imm1 <= data1 XOR data2;
		imm2 <= imm1 AND c_in;
		imm3 <= data1 AND data2;
		sum <= imm1 XOR c_in;
		c_out <= imm2 or imm3;
end simple;
	
	