LIBRARY ieee; 
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY array_mult_nbit IS
	generic (N : integer := 8);
	PORT(
		a: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		b: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		
		p: OUT STD_LOGIC_VECTOR(2*N-1 DOWNTO 0)
	);
END array_mult_nbit;

ARCHITECTURE arch OF array_mult_nbit IS
	TYPE array1d is array (0 to N-1) of STD_LOGIC;
	TYPE array2d is array (0 to N-1) of STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL overflow : STD_LOGIC;
	SIGNAL cout : array1d;
	SIGNAL s : array2d;
	SIGNAL x, y : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL q : STD_LOGIC_VECTOR(2*N-1 DOWNTO 0);

	component rca_nbit is
		generic (N : integer);
		port(a, b : IN std_logic_vector(N-1 downto 0);
		cin, sub : IN std_logic;
		cout, overflow : OUT std_logic;
		sum : OUT std_logic_vector(N-1 downto 0));
	end component;
	
BEGIN
	x <= a;
	y <= b;
	cout(0) <= '0';
	s(0) <= x(N-1 downto 0) and (N-1 downto 0 => y(0));
	q(0) <= s(0)(0);
	
	GEN_RCA:
	for I in 1 to N-2 generate
		rcax: rca_nbit generic map(N) port map(cout(I-1) & s(I-1)(N-1 DOWNTO 1), x and (N-1 DOWNTO 0 => y(I)), '0', '0', cout(I), overflow, s(I));	
		q(I) <= s(I)(0);
	end generate GEN_RCA;
	
	rca: rca_nbit generic map(N) port map(cout(N-2) & s(N-2)(N-1 DOWNTO 1), x and (N-1 DOWNTO 0 => y(N-1)), '0', '0', cout(N-1), overflow, s(N-1));	
	q(2*N-2 DOWNTO (N-1)) <= s(N-1);
	q(2*N-1) <= cout(N-1);
	p <= q;
END arch;
