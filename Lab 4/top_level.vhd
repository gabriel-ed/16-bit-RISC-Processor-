library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port(clk    : in std_logic;
         pc2     : in std_logic_vector(15 downto 0));
end top_level;

architecture structural of top_level is

    -- component declaration 
    component PC is
        port (clk   : in std_logic;
              inst_addr : in std_logic_vector(15 downto 0);
              inst_fetch: out std_logic_vector(15 downto 0));
    end component;
    
    component instruction_memory is
        port (clk   : in std_logic;
              inst_address  :   in std_logic_vector(15 downto 0);
              instruction   :   out std_logic_vector(15 downto 0));
    end component;
    
    component control_unit is
        port (opcode :   in std_logic_vector(15 downto 12);
              regDst :   out std_logic;
              jump   :   out std_logic;
              branch :   out std_logic;
              MemRead:   out std_logic;
              Mem_Reg:   out std_logic;
              aluOp  :   out std_logic_vector(2 downto 0);
              MemWrite:  out std_logic;
              aluSrc :   out std_logic;
              regWrite:  out std_logic);
    end component;
    
    component regfile is
        port (clk   : in std_logic;
              instruction   : in std_logic_vector(15 downto 0);
              regDst, regWrite : in std_logic;
              data_write    : in std_logic_vector(15 downto 0);
              read_data1    : out std_logic_vector(15 downto 0);
              read_data2    : out std_logic_vector(15 downto 0));
    end component;
    
    component alu_control is
        port (aluOp : in std_logic_vector(2 downto 0);
              aluFunc   :   in std_logic_vector(2 downto 0);
              aluCont   :   out std_logic_vector(2 downto 0));
    end component;
    
    component ALU is
        port (data1 : in std_logic_vector(15 downto 0);
              data2 : in std_logic_vector(15 downto 0);
              aluop : in std_logic_vector(2 downto 0);
              zero  : out std_logic;
              result: out std_logic_vector(15 downto 0));
    end component;
    
    component data_memory is
        port (clk   : in std_logic;
              mem_address   : in std_logic_vector(15 downto 0);
              data_write    : in std_logic_vector(15 downto 0);
              mem_write     : in std_logic;
              mem_read      : in std_logic;
              data_read     : out std_logic_vector(15 downto 0));
    end component;
    
    component mux is 
        port (data1 :   in std_logic_vector(15 downto 0);
              data2 :   in std_logic_vector(15 downto 0);
              sel   :   in std_logic;
              output:   out std_logic_vector(15 downto 0));
    end component;
    
    component mux_wb is
        port (data1 :   in std_logic_vector(15 downto 0);
              data2 :   in std_logic_vector(15 downto 0);
              sel   :   in std_logic;
              output:   out std_logic_vector(15 downto 0));
    end component;       
    
    component sign_extend is
        port (data1 : in std_logic_vector(11 downto 0);
              out_data : out std_logic_vector(15 downto 0));
    end component;
    
    component pc_add is
        port (address : in std_logic_vector(15 downto 0);
              output  : out std_logic_vector(15 downto 0));
    end component;
    
    component jump_component is
        port (instruction : in std_logic_vector(15 downto 0);
              next_pc   : in std_logic_vector(3 downto 0);
              jump_address : out std_logic_vector(15 downto 0));
    end component;
    
    component branch_add is
        port (address1 : in std_logic_vector(15 downto 0);
              address2 : in std_logic_vector(15 downto 0);
              output   : out std_logic_vector(15 downto 0));
    end component;
    
    
    -- component instantioation --
    FOR ALL : PC USE ENTITY work.PC(simple);
    FOR ALL : instruction_memory USE ENTITY work.instruction_memory(simple);
    FOR ALL : control_unit USE ENTITY work.control_unit(simple);
    FOR ALL : regfile USE ENTITY work.regfile(simple);
    FOR ALL : alu_control USE ENTITY work.alu_control(simple);
    FOR ALL : ALU USE ENTITY work.ALU(simple);
    FOR ALL : data_memory USE ENTITY work.data_memory(simple);
    FOR ALL : mux USE ENTITY work.mux(simple);
    FOR ALL : mux_wb USE ENTITY work.mux_wb(simple);
    FOR ALL : sign_extend USE ENTITY work.sign_extend(simple);
    FOR ALL : pc_add USE ENTITY work.pc_add(simple);
    FOR ALL : jump_component USE ENTITY work.jump_component(simple);
    FOR ALL : branch_add USE ENTITY work.branch_add(simple);
    
    -- signal setup --
    signal next_instruction_sig : std_logic_vector(15 downto 0);
    signal instruction_sig, instruction_address_sig, next_instr_add_sig , ALUMain_res_sig, ALUBranch_res_sig, writeback_sig, data1_sig, data2_sig, ALU_muxin1_sig, mux2alu_sig, jump_address_sig, mux_inter1_sig, data_mem_sig, mux_wb_sig: std_logic_vector(15 downto 0);
    signal alu_zero_sig, RegDst_sig, Jump_sig, Branch_sig, MemRead_sig, MemtoReg_sig, MemWrite_sig, ALUSrc_sig, RegWrite_sig, clk_sig : std_logic;
    signal ALUOpC_Sig, aluOp_sig : std_logic_vector(2 downto 0);
    signal branch_mux_cntrl : std_logic;
    signal instruction_sig_int : integer := 0;

    begin
        branch_mux_cntrl <= Branch_sig AND alu_zero_sig;
        clk_sig <= clk;
        pc_driver : process(clk, next_instr_add_sig)
        begin
            clk_sig <= clk;
            if rising_edge(clk) then
                instruction_address_sig <= pc2;
            elsif next_instr_add_sig = x"0010" then
		instruction_address_sig <= x"0000";
	    end if;
            
        end process pc_driver;

	--end_proc : process(clk, next_instr_add_sig)
	--begin
	--if next_instr_add_sig = x"0010" then
	--	instruction_address_sig <= x"0000";
	--end if;
	--end process end_proc;
    -- port connections --
        --PC_MAIN : PC port map (clk => clk_sig, inst_addr => next_instruction_sig, inst_fetch => instruction_address_sig);
        
        INST_MEM : instruction_memory port map (clk => clk_sig, inst_address => instruction_address_sig, instruction => instruction_sig);
        
        CTRL_MAIN : control_unit port map (opcode => instruction_sig(15 downto 12), regDst => RegDst_sig, jump => Jump_sig, branch => Branch_sig, MemRead => MemRead_sig, Mem_Reg => MemtoReg_sig, aluOp => ALUOpC_Sig, MemWrite => MemWrite_sig, aluSrc => ALUSrc_sig, regWrite => RegWrite_sig);
        
        REG_F   : regfile port map (clk => clk_sig, instruction => instruction_sig, regDst => RegDst_sig, regWrite => RegWrite_sig, data_write => writeback_sig, read_data1 => data1_sig, read_data2 => data2_sig);
        
        CTRL_ALU : alu_control port map (aluOp => ALUOpC_Sig, aluFunc => instruction_sig(2 downto 0), aluCont => aluOp_sig);
        
        ALU_MAIN : ALU port map (data1 => data1_sig, data2 => mux2alu_sig, aluop =>aluOp_sig, zero => alu_zero_sig, result => ALUMain_res_sig);
        
        DATA_MEM : data_memory port map (clk => clk_sig, mem_address => ALUMain_res_sig, data_write => data2_sig, mem_write => MemWrite_sig, mem_read => MemRead_sig, data_read => data_mem_sig);
        
        Sign_Ext : sign_extend port map (data1 => instruction_sig(11 downto 0), out_data => ALU_muxin1_sig);
        
        mux_ALU : mux port map (data1 => data2_sig, data2 => ALU_muxin1_sig, sel => ALUSrc_sig, output => mux2alu_sig);

        mux_wb1  : mux_wb port map (data1 => ALUMain_res_sig, data2 => data_mem_sig, sel => MemtoReg_sig, output => writeback_sig);
        
        pc_adder : pc_add port map (address => instruction_address_sig, output => next_instr_add_sig);
        
        jump    : jump_component port map (instruction => instruction_sig, next_pc => instruction_sig(15 downto 12), jump_address => jump_address_sig);
        
        mux_pc_next : mux port map (data1 => mux_inter1_sig, data2 => jump_address_sig, sel => Jump_sig, output => next_instruction_sig);
        
        branch_adder : branch_add port map (address1 => next_instr_add_sig, address2 => ALU_muxin1_sig, output => ALUBranch_res_sig);
    
        mux_branch : mux port map (data1 => next_instr_add_sig, data2 => ALUBranch_res_sig, sel => branch_mux_cntrl, output => mux_inter1_sig);

end structural;
