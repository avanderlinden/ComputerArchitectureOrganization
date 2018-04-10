library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity jump is
	port
	(
		branchalu		: in  std_logic;
		branchcontrol		: in  std_logic_vector (2 downto 0);
		extend			: in  std_logic_vector (31 downto 0);
		jump			: in  std_logic_vector (25 downto 0);
		registers		: in  std_logic_vector (31 downto 0);
		current			: in  std_logic_vector (31 downto 0);
		branch			: out std_logic;
		address			: out std_logic_vector (31 downto 0);
		writereg		: out std_logic_vector (4 downto 0);
		writedata		: out std_logic_vector (31 downto 0)
	);
end jump;

architecture behavior of jump is
	signal addresscalc : unsigned (31 downto 0);
begin
	addresscalc <= unsigned (current) + (shift_left (unsigned (extend), 2));
	process (branchalu, branchcontrol, extend, jump, registers, current, addresscalc)
	begin
		case branchcontrol is
			when "001" =>		-- j
				branch	<= '1';
				address	<= current (31 downto 28) & jump & "00";
			when "010" =>		-- jr
				branch	<= '1';
				address	<= registers;
			when "100" => 		-- jal
				branch <= '1';
				address	<= current (31 downto 28) & jump & "00";
				--writereg <= "11111";
				writedata <= current;
			when "011" =>		-- branch instruction
				branch	<= branchalu;
				address	<= std_logic_vector (addresscalc);
			when others =>
				branch	<= '0';
				address	<= "00000000000000000000000000000000";
		end case;
	end process;
end behavior;
