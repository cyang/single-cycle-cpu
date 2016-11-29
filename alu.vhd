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
	SIGNAL add_result, sub_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL cout_add, cout_sub, overflow_add, overflow_sub : STD_LOGIC;
	COMPONENT rca_nbit IS
		generic (N : integer := 8);
		port(a, b : in std_logic_vector(N-1 downto 0);
			cin, sub : in std_logic;
			cout, overflow : out std_logic;
			sum : out std_logic_vector(N-1 downto 0)
		);
	END COMPONENT;
	
BEGIN
	--rca1: rca_nbit generic MAP(32) PORT MAP(a, b, '0', '0', cout_add, overflow_add, add_result);
	--rca2: rca_nbit GENERIC MAP(32) PORT MAP(a, b, '1', '1', cout_sub, overflow_sub, sub_result); 


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
		END IF;
	END PROCESS;
END arch;
	