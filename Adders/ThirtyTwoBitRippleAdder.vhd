LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ThirtyTwoBitRippleAdder IS
    PORT (
        InputA, InputB : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        CarryIN : IN STD_LOGIC;
        Sum : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        CarryOUT : OUT STD_LOGIC
    );
END ENTITY ThirtyTwoBitRippleAdder;

ARCHITECTURE rtl OF ThirtyTwoBitRippleAdder IS
    SIGNAL C : STD_LOGIC_VECTOR(30 DOWNTO 0);

    COMPONENT FullAdder IS
        PORT (
            A, B, Cin : IN STD_LOGIC;
            s, Cout : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    FA0: FullAdder 
    PORT MAP (
        A => InputA(0), B => InputB(0), Cin => CarryIN,
        s => Sum(0), Cout => C(0)
    );

    FA1: FullAdder 
    PORT MAP (
        A => InputA(1), B => InputB(1), Cin => C(0),
        s => Sum(1), Cout => C(1)
    );

    FA2: FullAdder 
    PORT MAP (
        A => InputA(2), B => InputB(2), Cin => C(1),
        s => Sum(2), Cout => C(2)
    );

    FA3: FullAdder 
    PORT MAP (
        A => InputA(3), B => InputB(3), Cin => C(2),
        s => Sum(3), Cout => C(3)
    );

    FA4: FullAdder 
    PORT MAP (
        A => InputA(4), B => InputB(4), Cin => C(3),
        s => Sum(4), Cout => C(4)
    );

    FA5: FullAdder 
    PORT MAP (
        A => InputA(5), B => InputB(5), Cin => C(4),
        s => Sum(5), Cout => C(5)
    );

    FA6: FullAdder 
    PORT MAP (
        A => InputA(6), B => InputB(6), Cin => C(5),
        s => Sum(6), Cout => C(6)
    );

    FA7: FullAdder 
    PORT MAP (
        A => InputA(7), B => InputB(7), Cin => C(6),
        s => Sum(7), Cout => C(7)
    );

    FA8: FullAdder 
    PORT MAP (
        A => InputA(8), B => InputB(8), Cin => C(7),
        s => Sum(8), Cout => C(8)
    );

    FA9: FullAdder 
    PORT MAP (
        A => InputA(9), B => InputB(9), Cin => C(8),
        s => Sum(9), Cout => C(9)
    );

    FA10: FullAdder 
    PORT MAP (
        A => InputA(10), B => InputB(10), Cin => C(9),
        s => Sum(10), Cout => C(10)
    );
    
    FA11: FullAdder 
    PORT MAP (
        A => InputA(11), B => InputB(11), Cin => C(10),
        s => Sum(11), Cout => C(11)
    );
    
    FA12: FullAdder 
    PORT MAP (
        A => InputA(12), B => InputB(12), Cin => C(11),
        s => Sum(12), Cout => C(12)
    );
    
    FA13: FullAdder 
    PORT MAP (
        A => InputA(13), B => InputB(13), Cin => C(12),
        s => Sum(13), Cout => C(13)
    );
    
    FA14: FullAdder 
    PORT MAP (
        A => InputA(14), B => InputB(14), Cin => C(13),
        s => Sum(14), Cout => C(14)
    );
    
    FA15: FullAdder 
    PORT MAP (
        A => InputA(15), B => InputB(15), Cin => C(14),
        s => Sum(15), Cout => C(15)
    );
        
    FA16: FullAdder 
    PORT MAP (
        A => InputA(16), B => InputB(16), Cin => C(15),
        s => Sum(16), Cout => C(16)
    );

    FA17: FullAdder 
    PORT MAP (
        A => InputA(17), B => InputB(17), Cin => C(16),
        s => Sum(17), Cout => C(17)
    );

    FA18: FullAdder 
    PORT MAP (
        A => InputA(18), B => InputB(18), Cin => C(17),
        s => Sum(18), Cout => C(18)
    );

    FA19: FullAdder 
    PORT MAP (
        A => InputA(19), B => InputB(19), Cin => C(18),
        s => Sum(19), Cout => C(19)
    );

    FA20: FullAdder 
    PORT MAP (
        A => InputA(20), B => InputB(20), Cin => C(19),
        s => Sum(20), Cout => C(20)
    );

    FA21: FullAdder 
    PORT MAP (
        A => InputA(21), B => InputB(21), Cin => C(20),
        s => Sum(21), Cout => C(21)
    );

    FA22: FullAdder 
    PORT MAP (
        A => InputA(22), B => InputB(22), Cin => C(21),
        s => Sum(22), Cout => C(22)
    );

    FA23: FullAdder 
    PORT MAP (
        A => InputA(23), B => InputB(23), Cin => C(22),
        s => Sum(23), Cout => C(23)
    );

    FA24: FullAdder 
    PORT MAP (
        A => InputA(24), B => InputB(24), Cin => C(23),
        s => Sum(24), Cout => C(24)
    );

    FA25: FullAdder 
    PORT MAP (
        A => InputA(25), B => InputB(25), Cin => C(24),
        s => Sum(25), Cout => C(25)
    );

    FA26: FullAdder 
    PORT MAP (
        A => InputA(26), B => InputB(26), Cin => C(25),
        s => Sum(26), Cout => C(26)
    );

    FA27: FullAdder 
    PORT MAP (
        A => InputA(27), B => InputB(27), Cin => C(26),
        s => Sum(27), Cout => C(27)
    );

    FA28: FullAdder 
    PORT MAP (
        A => InputA(28), B => InputB(28), Cin => C(27),
        s => Sum(28), Cout => C(28)
    );

    FA29: FullAdder 
    PORT MAP (
        A => InputA(29), B => InputB(29), Cin => C(28),
        s => Sum(29), Cout => C(29)
    );

    FA30: FullAdder 
    PORT MAP (
        A => InputA(30), B => InputB(30), Cin => C(29),
        s => Sum(30), Cout => C(30)
    );

    FA31: FullAdder 
    PORT MAP (
        A => InputA(31), B => InputB(31), Cin => C(30),
        s => Sum(31), Cout => CarryOUT
    );

END rtl;
