Library ieee;
use ieee.std_logic_1164.all;
entity FA is
 port(a, b : in std_logic;
 cin : in std_logic;
 cout : out std_logic;
 sum : out std_logic);
end FA;
architecture arch of FA is
begin
 cout <= (a and b) or ((a xor b) and cin) ; --complete this
 sum <= a xor b xor cin;
end arch;
