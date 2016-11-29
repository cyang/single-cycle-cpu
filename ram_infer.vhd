LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ram_infer IS
   PORT
   (
      address:  IN std_logic_vector(31 DOWNTO 0);
		clock: IN   std_logic;
		data:  IN   std_logic_vector (31 DOWNTO 0);
      we:    IN   std_logic;
      q:     OUT  std_logic_vector (31 DOWNTO 0)
   );
END ram_infer;
ARCHITECTURE rtl OF ram_infer IS
   TYPE mem IS ARRAY(0 TO 4294967295) OF std_logic_vector(31 DOWNTO 0);
   SIGNAL ram_block : mem;
BEGIN
   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (we = '1') THEN
            ram_block(to_integer(unsigned(address))) <= data;
         END IF;
      END IF;
		q <= ram_block(to_integer(unsigned(address)));
   END PROCESS;
END rtl;