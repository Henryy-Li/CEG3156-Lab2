LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ThirtyTwoBitAdderSubtractor is 
    PORT
    (
        InputA, InputB  : IN STD_LOGIC_VECTOR(31 downto 0);
        Operation   :   IN STD_LOGIC;
        Result    :   OUT STD_LOGIC_VECTOR(31 downto 0);
        CarryOUT    :   OUT STD_LOGIC
    );
END ThirtyTwoBitAdderSubtractor;

ARCHITECTURE rtl of ThirtyTwoBitAdderSubtractor is
    SIGNAL B_Feed, Operation_Vector  :   STD_LOGIC_VECTOR(31 downto 0);

    COMPONENT ThirtyTwoBitRippleAdder IS
        PORT (
            InputA, InputB : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            CarryIN : IN STD_LOGIC;
            Sum : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            CarryOUT : OUT STD_LOGIC
        );
    END COMPONENT;
    
BEGIN
    Operation_Vector <= (others => Operation);
    B_Feed <= InputB XOR Operation_Vector;

    RA: ThirtyTwoBitRippleAdder
        PORT MAP (
            InputA => InputA,
            InputB => B_Feed,
            CarryIN => Operation,
            Sum => Result,
            CarryOUT => CarryOUT
        );
END rtl;
