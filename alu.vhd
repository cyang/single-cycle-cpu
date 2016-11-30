LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY alu IS
	PORT (
		a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ctr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		zero: OUT STD_LOGIC
	);
END alu;

ARCHITECTURE arch OF alu IS
	SIGNAL mult_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL div_result : STD_LOGIC_VECTOR(3 DOWNTO 0);
	COMPONENT array_mult_nbit IS
		generic (N : integer := 8);
		PORT(
			a: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			b: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			
			p: OUT STD_LOGIC_VECTOR(2*N-1 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT divider IS 
		PORT
		(
			dividend :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			divisor :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			quotient :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;
	
BEGIN
	m1 : array_mult_nbit GENERIC MAP (16) PORT MAP (a(15 DOWNTO 0), b(15 DOWNTO 0), mult_result);
	d1 : divider PORT MAP (a(3 DOWNTO 0), b(3 DOWNTO 0), div_result);
	

	PROCESS(ctr)
	BEGIN
		IF (ctr = "0010") THEN
			q <= a + b;
		ELSIF (ctr = "0110") THEN
			q <= a - b;
			IF ((a-b) = (31 DOWNTO 0 => '0')) THEN
				zero <= '1';
			ELSE 
				zero <= '0';
			END IF;
		ELSIF (ctr = "0000") THEN
			q <= a AND b;
		ELSIF (ctr = "0001") THEN
			q <= a OR b;
		ELSIF (ctr = "1000") THEN
			q <= mult_result;
		ELSIF (ctr = "1001") THEN
			q(31 DOWNTO 4) <= (others => '0');
			q(3 DOWNTO 0) <= div_result;
		END IF;
	END PROCESS;
END arch;
	