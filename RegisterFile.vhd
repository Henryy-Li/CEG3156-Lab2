LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegisterFile IS
    PORT 
    (
        i_readSelect1, i_readSelect2, i_writeSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  i_writeData : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  i_clock, i_reset, i_regWrite : IN STD_LOGIC;
        o_readData1, o_readData2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY RegisterFile;

ARCHITECTURE rtl OF RegisterFile IS
	COMPONENT EightBitGPRegister 
	PORT 
    (
        -- Register Operations
        i_resetBar : IN STD_LOGIC;
        i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
        i_decrement, i_increment : IN STD_LOGIC;

        -- Register Signals
        i_serial_in_left, i_serial_in_right : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_Value : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_Value : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
	 END COMPONENT;
	 
	 COMPONENT EightBitEightToOneMux
	 PORT (
        i_mux_0, i_mux_1, i_mux_2, i_mux_3 : IN STD_LOGIC_VECTOR(7 downto 0);
        i_mux_4, i_mux_5, i_mux_6, i_mux_7 : IN STD_LOGIC_VECTOR(7 downto 0);
        o_mux: OUT STD_LOGIC_VECTOR(7 downto 0);
        sel0, sel1, sel2: IN STD_LOGIC
    );
	 END COMPONENT;
	 
	 COMPONENT ThreeToEightDecoder
	 PORT 
    (
        inputs : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        outputs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
	 END COMPONENT;
	 SIGNAL int_enableRegister, int_register0out, int_register1out, int_register2out, int_register3out, int_register4out, int_register5out, int_register6out, int_register7out : STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL int_resetBar : STD_LOGIC;
BEGIN
	int_resetBar <= not i_reset;
	
	enableDecoder : ThreeToEightDecoder
	PORT MAP (i_writeSelect, int_enableRegister);
	
	readPort1 : EightBitEightToOneMux
	PORT MAP(
		i_mux_0 => int_register0out,
		i_mux_1 => int_register1out,
		i_mux_2 => int_register2out,
		i_mux_3 => int_register3out,
		i_mux_4 => int_register4out,
		i_mux_5 => int_register5out,
		i_mux_6 => int_register6out,
		i_mux_7 => int_register7out,
		o_mux => o_readData1,
		sel0 => i_readSelect1(0),
		sel1 => i_readSelect1(1),
		sel2 => i_readSelect1(2)
	);
	
	readPort2 : EightBitEightToOneMux
	PORT MAP(
		i_mux_0 => int_register0out,
		i_mux_1 => int_register1out,
		i_mux_2 => int_register2out,
		i_mux_3 => int_register3out,
		i_mux_4 => int_register4out,
		i_mux_5 => int_register5out,
		i_mux_6 => int_register6out,
		i_mux_7 => int_register7out,
		o_mux => o_readData2,
		sel0 => i_readSelect2(0),
		sel1 => i_readSelect2(1),
		sel2 => i_readSelect2(2)
	);
	
	register0 : EightBitGPRegister 
	PORT MAP
    (
        i_resetBar => int_resetBar,
        i_load => int_enableRegister(0) and i_regWrite, 
		  i_shiftLeft => '0',
		  i_shiftRight => '0',
        i_decrement => '0',
		  i_increment => '0',
        i_serial_in_left => '0', 
		  i_serial_in_right => '0', 
        i_clock => i_clock,
        i_Value => i_writeData,
        o_Value => int_register0out
    );
	 
	register1 : EightBitGPRegister 
	PORT MAP
    (
        i_resetBar => int_resetBar,
        i_load => int_enableRegister(1) and i_regWrite, 
		  i_shiftLeft => '0',
		  i_shiftRight => '0',
        i_decrement => '0',
		  i_increment => '0',
        i_serial_in_left => '0', 
		  i_serial_in_right => '0', 
        i_clock => i_clock,
        i_Value => i_writeData,
        o_Value => int_register1out
    );
	 
	register2 : EightBitGPRegister 
	PORT MAP
    (
        i_resetBar => int_resetBar,
        i_load => int_enableRegister(2) and i_regWrite, 
		  i_shiftLeft => '0',
		  i_shiftRight => '0',
        i_decrement => '0',
		  i_increment => '0',
        i_serial_in_left => '0', 
		  i_serial_in_right => '0', 
        i_clock => i_clock,
        i_Value => i_writeData,
        o_Value => int_register2out
    );
	 
	register3 : EightBitGPRegister 
	PORT MAP
    (
        i_resetBar => int_resetBar,
        i_load => int_enableRegister(3) and i_regWrite, 
		  i_shiftLeft => '0',
		  i_shiftRight => '0',
        i_decrement => '0',
		  i_increment => '0',
        i_serial_in_left => '0', 
		  i_serial_in_right => '0', 
        i_clock => i_clock,
        i_Value => i_writeData,
        o_Value => int_register3out
    );
	 
	register4 : EightBitGPRegister 
	PORT MAP
    (
        i_resetBar => int_resetBar,
        i_load => int_enableRegister(4) and i_regWrite, 
		  i_shiftLeft => '0',
		  i_shiftRight => '0',
        i_decrement => '0',
		  i_increment => '0',
        i_serial_in_left => '0', 
		  i_serial_in_right => '0', 
        i_clock => i_clock,
        i_Value => i_writeData,
        o_Value => int_register4out
    );
	 
	register5 : EightBitGPRegister 
	PORT MAP
    (
        i_resetBar => int_resetBar,
        i_load => int_enableRegister(5) and i_regWrite, 
		  i_shiftLeft => '0',
		  i_shiftRight => '0',
        i_decrement => '0',
		  i_increment => '0',
        i_serial_in_left => '0', 
		  i_serial_in_right => '0', 
        i_clock => i_clock,
        i_Value => i_writeData,
        o_Value => int_register5out
    );
	 
	register6 : EightBitGPRegister 
	PORT MAP
    (
        i_resetBar => int_resetBar,
        i_load => int_enableRegister(6) and i_regWrite, 
		  i_shiftLeft => '0',
		  i_shiftRight => '0',
        i_decrement => '0',
		  i_increment => '0',
        i_serial_in_left => '0', 
		  i_serial_in_right => '0', 
        i_clock => i_clock,
        i_Value => i_writeData,
        o_Value => int_register6out
    );
	 
	register7 : EightBitGPRegister 
	PORT MAP
    (
        i_resetBar => int_resetBar,
        i_load => int_enableRegister(7) and i_regWrite, 
		  i_shiftLeft => '0',
		  i_shiftRight => '0',
        i_decrement => '0',
		  i_increment => '0',
        i_serial_in_left => '0', 
		  i_serial_in_right => '0', 
        i_clock => i_clock,
        i_Value => i_writeData,
        o_Value => int_register7out
    );
END rtl;
