LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sign_extend IS
	PORT (
		a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ExtOp: IN STD_LOGIC;
		q: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END sign_extend;

ARCHITECTURE arch OF sign_extend IS
	
BEGIN	
	PROCESS(ExtOp)
	BEGIN
		IF (ExtOp = '1') THEN
			q(31 DOWNTO 16) <= (others => a(15));
		ELSE
			q(31 DOWNTO 16) <= (others => '0');
		END IF;
		
		q(15 DOWNTO 0) <= a;
	END PROCESS;
END arch;
	