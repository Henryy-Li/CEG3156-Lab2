LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY ALU IS 
    PORT 
    (
        i_OPERAND_1, i_OPERAND_2    : IN STD_LOGIC_VECTOR(7 downto 0);
        i_OPERATION                 : IN STD_LOGIC_VECTOR(2 downto 0);
        o_RESULT                    : OUT STD_LOGIC_VECTOR(7 downto 0);
        o_ZERO                      : OUT STD_LOGIC;
        o_OVERFLOW                  : OUT STD_LOGIC
    );
END ALU;

ARCHITECTURE RTL OF ALU IS

    SIGNAL addersubtractor_result : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL operand_bitwise_and    : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL operand_bitwise_or     : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL int_zero               : STD_LOGIC;

    COMPONENT EightBitAdderSubtractor is 
    PORT
    (
        InputA, InputB      : IN STD_LOGIC_VECTOR(7 downto 0);
        Operation           :   IN STD_LOGIC;
        Result              :   OUT STD_LOGIC_VECTOR(7 downto 0);
        CarryOUT            :   OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT EightBitComparator IS
    PORT
    (
        i_Ai, i_Bi			: IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_GT, o_LT, o_EQ	: OUT	STD_LOGIC
    );
    END COMPONENT;
    
    COMPONENT EightToOne8BitMux IS
        PORT (
            i_mux_0, i_mux_1, i_mux_2, i_mux_3 : IN STD_LOGIC_VECTOR(7 downto 0);
            i_mux_4, i_mux_5, i_mux_6, i_mux_7 : IN STD_LOGIC_VECTOR(7 downto 0);
            o_mux: OUT STD_LOGIC_VECTOR(7 downto 0);
            sel0, sel1, sel2: IN STD_LOGIC
        );
    END COMPONENT;
    
BEGIN

    operand_bitwise_and <= i_OPERAND_1 and i_OPERAND_2;
    operand_bitwise_or <= i_OPERAND_1 or i_OPERAND_2;

    addersubtractor : EightBitAdderSubtractor
    PORT MAP
    (
        InputA => i_OPERAND_1, 
        InputB => i_OPERAND_2,
        Operation => i_OPERATION(2),
        Result => addersubtractor_result,
        CarryOUT => o_OVERFLOW
    );

    zero_comparator: EightBitComparator
    PORT MAP
    (
        i_Ai => addersubtractor_result,
        i_Bi => "00000000",
        o_GT => open,
        o_LT => open,
        o_EQ => int_zero
    );

    mux : EightToOne8BitMux
    PORT MAP
    (
        i_mux_0 => operand_bitwise_and,
        i_mux_1 => operand_bitwise_or,
        i_mux_2 => addersubtractor_result,
        i_mux_3 => "00000000",
        i_mux_4 => "00000000",
        i_mux_5 => "00000000",
        i_mux_6 => addersubtractor_result,
        i_mux_7 => "00000000",
        o_mux => o_RESULT,
        sel0 => i_OPERATION(0), 
        sel1 => i_OPERATION(1),
        sel2 => i_OPERATION(2)
    );

    o_ZERO <= i_OPERATION(0) and i_OPERATION(1) and i_OPERATION(2) and int_zero;

END RTL;
