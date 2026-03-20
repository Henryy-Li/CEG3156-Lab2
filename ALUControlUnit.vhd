LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY ALUControlUnit IS 
    PORT 
    (
        i_FUNC_CODE : IN STD_LOGIC_VECTOR(5 downto 0);
        i_ALU_OP    : IN STD_LOGIC_VECTOR(1 downto 0);
        o_OPERATION : OUT STD_LOGIC_VECTOR(2 downto 0)
    );
END ALUControlUnit;

ARCHITECTURE RTL OF ALUControlUnit IS
    SIGNAL ALUOp0, ALUOp1 : STD_LOGIC;
    SIGNAL F3, F2, F1, F0 : STD_LOGIC;
    SIGNAL Operation2, Operation1, Operation0 : STD_LOGIC;
BEGIN
    ALUOp0 <= i_ALU_OP(0);
    ALUOp1 <= i_ALU_OP(1);
    F3 <= i_FUNC_CODE(3);
    F2 <= i_FUNC_CODE(2);
    F1 <= i_FUNC_CODE(1);
    F0 <= i_FUNC_CODE(0);

    Operation2 <= (F1 AND ALUOp1) OR (ALUOp0);
    Operation1 <= (NOT F2) or (NOT ALUOp1);
    Operation0 <= (F0 OR F3) AND ALUOp1;

    o_OPERATION <= Operation2 & Operation1 & Operation0;

END RTL;
