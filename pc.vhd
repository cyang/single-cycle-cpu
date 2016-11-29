LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY pc IS
   PORT
   (
		imm32:  IN std_logic_vector(31 DOWNTO 0);
		branch, zero, clock: IN std_logic;
		out_address: OUT  std_logic_vector (31 DOWNTO 0)
   );
END pc;
ARCHITECTURE arch OF pc IS
	SIGNAL out_address_sig : STD_LOGIC_VECTOR(31 DOWNTO 0) := (31 DOWNTO 0 => '0');
BEGIN

   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
			IF (branch = '1' AND zero = '1') THEN
				out_address_sig <= out_address_sig + 4 + (to_stdlogicvector(to_bitvector(imm32) sll 2));
			ELSE 
				out_address_sig <= out_address_sig + 4;
			END IF;	
      END IF;
		
		out_address <= out_address_sig;
   END PROCESS;
END arch;