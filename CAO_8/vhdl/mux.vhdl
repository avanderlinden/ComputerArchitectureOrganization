library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc is
	port
	(
		jarSel 	 : in std_logic;
		regdst	 : in std_logic;
		aluWrite : in std_logic_vector(31 downto 0);
		jalWrite : in std_logic_vector(31 downto 0)
	);
end pc;

architecture behavior of pc is
	

begin

end behavior;
