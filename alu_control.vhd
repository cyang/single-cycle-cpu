LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY alu_control IS
	PORT (
		ALUOp: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		
		ALUCtr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END alu_control;

ARCHITECTURE arch OF alu_control IS
	
BEGIN
	PROCESS(ALUOp)
	BEGIN
		IF (ALUOp = "10") THEN
			-- addU/subU/multU/divU
			IF (funct = "100000") THEN
				-- addU
				ALUCtr <= "0010";
			ELSIF (funct = "100010") THEN
				-- subU
				ALUCtr <= "0110";
			ELSIF (funct = "100100") THEN
				-- multU
				ALUCtr <= "1000";
			ELSIF (funct <= "100110") THEN
				-- divU
				ALUCtr <= "1001";
			END IF;
		ELSIF (ALUOp = "00") THEN
			-- lw/sw
			ALUCtr <= "0010";
		ELSIF (ALUOp = "01") THEN
			-- ori
			ALUCtr <= "0001";
		ELSIF (ALUOp = "11") THEN	
			-- branch eq
			ALUCtr <= "0110";
		END IF;
	END PROCESS;
END arch;
	