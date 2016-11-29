LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.all;

ENTITY instruction_memory IS
   PORT
   (
      raddress:  IN std_logic_vector(31 DOWNTO 0);
      instruction: OUT  std_logic_vector (31 DOWNTO 0)
   );
END instruction_memory;

ARCHITECTURE arch OF instruction_memory IS
	type mem_t is array(0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
	signal ram : mem_t;
	attribute ram_init_file : string;
	attribute ram_init_file of ram :
	signal is "my_init_file.mif";
 
BEGIN

	instruction <= ram(to_integer(unsigned(raddress)));

END arch;
