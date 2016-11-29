LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY ram3port_vhdl IS
PORT
(
clock : IN STD_LOGIC ;
data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
rdaddress_a : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
rdaddress_b : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
wraddress : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
wren : IN STD_LOGIC := '1';
qa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
qb : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
);
END ram3port_vhdl;
ARCHITECTURE SYN OF ram3port_vhdl IS
	TYPE mem IS ARRAY(0 TO 31) OF std_logic_vector(31 DOWNTO 0);
   SIGNAL ram_block : mem;
BEGIN
	PROCESS(clock)
	BEGIN
		IF (clock'event and clock='1') THEN
			IF (wren = '1') THEN
            ram_block(to_integer(unsigned(wraddress))) <= data;
         END IF;
		END IF;
		qa <= ram_block(to_integer(unsigned(rdaddress_a)));
		qb <= ram_block(to_integer(unsigned(rdaddress_b)));
	END PROCESS;
END SYN;