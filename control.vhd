LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY control IS
	PORT (
		op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		regDst, branch, ExtOp, memToReg, memWr, ALUSrc, regWr, jump : OUT STD_LOGIC;
		ALUOp: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END control;

ARCHITECTURE arch OF control IS
	
BEGIN

	PROCESS(op)
	BEGIN
		
		IF (op = "000000") THEN
			-- addU/subU
			regDst <= '1';
			ALUSrc <= '0';
			
			regWr <= '1';
			
			branch <= '0';
			memToReg <= '0';
			memWr <= '0';
			
			jump <= '0';
			
			ALUOp <= "10";
		ELSIF (op = "100011") THEN
			-- load word
			regDst <= '0';
			ALUSrc <= '1';
			
			regWr <= '1';
			
			branch <= '0';
			memToReg <= '1';
			memWr <= '0';
			
			jump <= '0';
			
			ExtOp <= '1';
			ALUOp <= "00";
		ELSIF (op = "101011") THEN
			-- store word
			ALUSrc <= '1';
			
			regWr <= '0';
			
			branch <= '0';
			memWr <= '1';	
			
			jump <= '0';
		
			ExtOp <= '1';
			ALUOp <= "00";
		ELSIF (op = "001101") THEN 
			-- ori
			regDst <= '0';
			ALUSrc <= '1';
			
			memToReg <= '0';
			regWr <= '1';
			memWr <= '0';
			branch <= '0';
			
			jump <= '0';
			
			ExtOp <= '0';
			ALUOp <= "01";
		ELSIF (op = "000100") THEN
			-- branch eq
			ALUSrc <= '0';
			regWr <= '0';
			memWr <= '0';
			
			branch <= '1';
			
			jump <= '0';
			
			ALUOp <= "11";
		ELSIF (op = "000010") THEN
			-- jump
			regWr <= '0';
			memWr <= '0';
			
			jump <= '1';
		END IF;		
			
	
		
	END PROCESS;
END arch;
	