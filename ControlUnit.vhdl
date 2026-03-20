LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ENTITY ControlUnit is
    PORT
    (
        i_op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        o_RegDest, o_ALUSrc, o_MemToReg, o_RegWrite, o_MemRead, o_MemWrite, o_Branch, o_ALUOp0, o_ALUOp1, o_jump : OUT STD_LOGIC
    );
    END ControlUnit;

ARCHITECTURE rtl of ControlUnit is
SIGNAL int_rtype, int_lw, int_sw, int_beq, int_jmp : STD_LOGIC;
BEGIN
    -- Instruction type
    int_rtype <= (NOT i_op(0)) AND (NOT i_op(1)) AND (NOT i_op(2)) AND (NOT i_op(3)) AND (NOT i_op(4)) AND (NOT i_op(5));
    int_lw <= (i_op(0)) AND (i_op(1)) AND (NOT i_op(2)) AND (NOT i_op(3)) AND (NOT i_op(4)) AND (i_op(5));
    int_sw <= (i_op(0)) AND (i_op(1)) AND (NOT i_op(2)) AND (i_op(3)) AND (NOT i_op(4)) AND (i_op(5));
    int_beq <= (NOT i_op(0)) AND (NOT i_op(1)) AND (i_op(2)) AND (NOT i_op(3)) AND (NOT i_op(4)) AND (NOT i_op(5));
    int_jmp <= (NOT i_op(0)) AND (i_op(1)) AND (NOT i_op(2)) AND (NOT i_op(3)) AND (NOT i_op(4)) AND (NOT i_op(5));

    -- Control signals
    o_RegDest <= int_rtype;
    o_ALUSrc <= int_lw OR int_sw;
    o_MemToReg <= int_lw;
    o_RegWrite <= int_rtype OR int_lw;
    o_MemRead <= int_lw;
    o_MemWrite <= int_sw;
    o_Branch <= int_beq;
    o_ALUOp1 <= int_rtype;
    o_ALUOp0 <= int_beq;
    o_jump <= int_jmp;
END ARCHITECTURE;