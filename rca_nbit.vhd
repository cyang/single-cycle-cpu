library ieee;
use ieee.std_logic_1164.all;
entity RCA_NBIT is
	generic (N : integer := 8);
	port(a, b : in std_logic_vector(N-1 downto 0);
		cin, sub : in std_logic;
		cout, overflow : out std_logic;
		sum : out std_logic_vector(N-1 downto 0));
end RCA_NBIT;
architecture arch of RCA_NBIT is
 signal c: std_logic_vector(N downto 0);
 component FA is
 port(a, b, cin: in std_logic ; 
 cout : out std_logic;
 sum : out std_logic );
 end component;
 begin
		c(0) <= cin;
		GEN_FA:
		for I in 0 to N-1 generate
			FAX: FA port map(a(I), sub xor b(I), c(I), c(I+1), sum(I));
		end generate GEN_FA;

		 cout <= c(N);
		 overflow <= c(N) xor c(N-1);
end arch;