library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mips is
	port
	(
		clk					: in  std_logic;
		rst					: in  std_logic
	);
end mips;

architecture behavior of mips is

component alu
	port
	(
		data1		: in  std_logic_vector (31 downto 0);
		data2		: in  std_logic_vector (31 downto 0);
		shamt		: in  std_logic_vector ( 4 downto 0);
		aluinstr	: in  std_logic_vector ( 4 downto 0);
		result		: out std_logic_vector (31 downto 0);
		branch		: out std_logic
	);
end component;

component alucontrol
	port
	(
		aluop		: in  std_logic_vector (2 downto 0);
		instruction	: in  std_logic_vector (5 downto 0);
		branch1		: in  std_logic;
		branch2		: in  std_logic_vector (1 downto 0);
		aluinstr	: out std_logic_vector (4 downto 0)
	);
end component;

component control
	port
	(
		instruction	: in  std_logic_vector (5 downto 0);
		funct		: in  std_logic_vector (5 downto 0);
		branch		: out std_logic_vector (1 downto 0);
		regdst		: out std_logic;
		memread		: out std_logic;
		memtoreg	: out std_logic;
		aluop		: out std_logic_vector (2 downto 0);
		memwrite	: out std_logic;
		alusrc		: out std_logic;
		regwrite	: out std_logic
	);
end component;

component extend
	port
	(
		aluop		: in  std_logic_vector ( 2 downto 0);
		instruction	: in  std_logic_vector (15 downto 0);
		value		: out std_logic_vector (31 downto 0)
	);
end component;

component jump
	port
	(
		branchalu	: in  std_logic;
		branchcontrol	: in  std_logic_vector ( 1 downto 0);
		extend		: in  std_logic_vector (31 downto 0);
		jump		: in  std_logic_vector (25 downto 0);
		registers	: in  std_logic_vector (31 downto 0);
		current		: in  std_logic_vector (31 downto 0);
		branch		: out std_logic;
		address		: out std_logic_vector (31 downto 0)
	);
end component;

component memory
	port
	(
		clk		: in  std_logic;
		rst		: in  std_logic;
		memread		: in  std_logic;
		memwrite	: in  std_logic;
		address1	: in  std_logic_vector (31 downto 0);
		address2	: in  std_logic_vector (31 downto 0);
		writedata	: in  std_logic_vector (31 downto 0);
		instruction	: out std_logic_vector (31 downto 0);
		readdata	: out std_logic_vector (31 downto 0)
	);
end component;

component pc
	port
	(
		clk		: in  std_logic;
		rst		: in  std_logic;
		jump		: in  std_logic;
		pc_in		: in  std_logic_vector (31 downto 0);
		pc_add		: out std_logic_vector (31 downto 0);
		pc		: out std_logic_vector (31 downto 0)
	);
end component;

component registers
	port
	(
		clk		: in  std_logic;
		rst		: in  std_logic;
		regwrite	: in  std_logic;
		readreg1	: in  std_logic_vector ( 4 downto 0);
		readreg2	: in  std_logic_vector ( 4 downto 0);
		writereg	: in  std_logic_vector ( 4 downto 0);
		writedata	: in  std_logic_vector (31 downto 0);
		readdata1	: out std_logic_vector (31 downto 0);
		readdata2	: out std_logic_vector (31 downto 0)
	);
end component;

	signal branch, branchalu, regwrite, regdst, memread, memtoreg, memwrite, alusrc : std_logic;
	signal branchcontrol	: std_logic_vector (1 downto 0);
	signal aluop		: std_logic_vector (2 downto 0);
	signal aluinstr		: std_logic_vector (4 downto 0);
	signal writereg		: std_logic_vector (4 downto 0);
	signal branchaddress, extended, instruction, readdata1, readdata2, memorydata, current_pc, add_pc, writedata, result, aludatasel	: std_logic_vector (31 downto 0);

begin
	with regdst select
		writereg <=	instruction (15 downto 11)	when '1',
				instruction (20 downto 16)	when others;

	with memtoreg select
		writedata <=	memorydata			when '1',
				result				when others;

	with alusrc select
		aludatasel <=	extended			when '1',
				readdata2			when others;

pcmap:		pc		port map (	clk		=> clk,
						rst		=> rst,
						jump		=> branch,
						pc_in		=> branchaddress,
						pc_add		=> add_pc,
						pc		=> current_pc
				);

jumpmap:	jump		port map (	branchalu	=> branchalu,
						branchcontrol	=> branchcontrol,
						extend		=> extended,
						jump		=> instruction (25 downto 0),
						registers	=> readdata1,
						current		=> add_pc,
						branch		=> branch,
						address		=> branchaddress
				);

extendmap:	extend		port map (	aluop		=> aluop,
						instruction	=> instruction (15 downto 0),
						value		=> extended
				);

registersmap:	registers	port map (	clk		=> clk,
						rst		=> rst,
						regwrite	=> regwrite,
						readreg1	=> instruction (25 downto 21),
						readreg2	=> instruction (20 downto 16),
						writereg	=> writereg,
						writedata	=> writedata,
						readdata1	=> readdata1,
						readdata2	=> readdata2
				);

memorymap:	memory		port map (	clk		=> clk,
						rst		=> rst,
						memread		=> memread,
						memwrite	=> memwrite,
						address1	=> current_pc,
						address2	=> result,
						writedata	=> readdata2,
						instruction	=> instruction,
						readdata	=> memorydata
				);

controlmap:	control		port map (	instruction	=> instruction (31 downto 26),
						funct		=> instruction (5 downto 0),
						branch		=> branchcontrol,
						regdst		=> regdst,
						memread		=> memread,
						memtoreg	=> memtoreg,
						aluop		=> aluop,
						memwrite	=> memwrite,
						alusrc		=> alusrc,
						regwrite	=> regwrite
				);

alucontrolmap:	alucontrol	port map (	aluop		=> aluop,
						instruction	=> instruction (5 downto 0),
						branch1		=> instruction (16),
						branch2		=> instruction (27 downto 26),
						aluinstr	=> aluinstr
				);

alumap:		alu		port map (	data1		=> readdata1,
						data2		=> aludatasel,
						shamt		=> instruction (10 downto 6),
						aluinstr	=> aluinstr,
						result		=> result,
						branch		=> branchalu
				);
end behavior;

