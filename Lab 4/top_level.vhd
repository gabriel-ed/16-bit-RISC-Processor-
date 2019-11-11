library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port(clk    : in std_logic);
end top_level;

architecture structural of top_level is

    -- component declaration 
    component PC is
        port (inst_addr : in std_logic_vector(15 downto 0);
              inst_fetch: out std_logic_vector(3 downto 0));
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
    
    -- component instantioation --
    FOR ALL : PC USE ENTITY work.PC(simple);
    FOR ALL : instruction_memory USE ENTITY work.instruction_memory(simple);
    FOR ALL : control_unit USE ENTITY work.control_unit(simple);
    FOR ALL : regfile USE ENTITY work.regfile(simple);
    FOR ALL : alu_control USE ENTITY work.alu_control(simple);
    FOR ALL : ALU USE ENTITY work.ALU(simple);
    FOR ALL : data_memory USE ENTITY work.data_memory(simple);
    FOR ALL : clock USE ENTITY work.clock(simple);
    FOR ALL : mux USE ENTITY work.mux(simple);
    
    -- signal setup --
    signal instruction_sig, instruction_address_sig, jump_address_sig, next_instruction_sig, sign_extended_sig, ALU_res_sig, writeback_sig, data1_sig, data2_sig, ALU_muxin0_sig, ALU_muxin1_sig, data_mux_1_sig: std_logic_vector(15 downto 0);
    signal alu_zero_sig, RegDst_sig, Jump_sig, Branch_sig, MemRead_sig, MemtoReg_sig, MemWrite_sig, ALUSrc_sig, RegWrite_sig, clk_sig : std_logic;
    signal ALUOpC_Sig, aluOp_sig : std_logic_vector(2 downto 0);


    begin
    -- port connections --
        PC_MAIN : PC port map (clk => clk_sig, inst_addr => next_instruction_sig, inst_fetch => instruction_address_sig);
        
        INST_MEM : instruction_memory port map (clk => clk_sig, inst_address => instruction_address_sig, instruction => instruction_sig);
        
        CTRL_MAIN : control_unit port map (opcode => instruction_sig(15 downto 12), regDst => RegDst_sig, jump => Jump_sig, branch => Branch_sig, MemRead => MemRead_sig, Mem_Reg => MemtoReg_sig, aluOp => ALUOpC_Sig, MemWrite => MemWrite_sig, aluSrc => ALUSrc_sig, regWrite => RegWrite_sig);
        
        REG_F   : regfile port map (clk => clk_sig, instruction => instruction_sig, regDst => RegDst_sig, regWrite => RegWrite_sig, data_write => writeback_sig, read_data1 => data1_sig, read_data2 => ALU_muxin0_sig);
        
        CTRL_ALU : alu_control port map (aluOp => ALUOpC_Sig, aluFunc => instruction(2 downto 0), aluCont => aluOp_sig);
        
        ALU_MAIN : ALU port map (data1 => data1_sig, data2 => data2_sig, aluop =>aluOp_sig, zero => alu_zero_sig, result => ALU_res_sig);
        
        DATA_MEM : data_memory port map (clk => clk_sig, mem_address => ALU_res_sig, data_write => data2_sig, mem_write => MemWrite_sig, mem_read => MemRead_sig, data_read => data_mux_1_sig);
        
        mux_ALU : mux port map (data1 => ALU_muxin0_sig, data2 => 





end structural;
