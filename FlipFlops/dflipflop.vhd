LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dflipflop IS
PORT(
	i_d : IN STD_LOGIC;
	i_clock : IN STD_LOGIC;
	i_enable : IN STD_LOGIC;
	i_async_reset : IN STD_LOGIC;
	i_async_set : IN STD_LOGIC;
	o_q, o_qBar : OUT STD_LOGIC);
END dflipflop;

ARCHITECTURE rtl OF dflipflop IS
	SIGNAL int_q, int_qBar : STD_LOGIC;
	SIGNAL int_final_q : STD_LOGIC;
	SIGNAL int_d, int_dBar : STD_LOGIC;
	SIGNAL int_notD, int_notClock : STD_LOGIC;
	SIGNAL int_mux_d : STD_LOGIC;
	SIGNAL int_q_or_async, int_qBar_or_async, int_clock_or_async : STD_LOGIC;
	COMPONENT enabledSRLatch
	PORT(
		i_set, i_reset : IN STD_LOGIC;
		i_enable : IN STD_LOGIC;
		o_q, o_qBar : OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT mux_2to1_top
	PORT(
		A : IN STD_LOGIC;
		B : IN STD_LOGIC;
		SEL : IN STD_LOGIC;
		X : OUT STD_LOGIC);
	END COMPONENT;
BEGIN
	-- Component Instantiation
	masterLatch: enabledSRLatch
	PORT MAP ( i_set => int_mux_d,
		i_reset => int_notD,
		i_enable => int_notClock,
		o_q => int_q,
		o_qBar => int_qBar);
	slaveLatch: enabledSRLatch
	PORT MAP ( i_set => int_q_or_async,
		i_reset => int_qBar_or_async,
		i_enable => int_clock_or_async,
		o_q => int_final_q,
		o_qBar => o_qBar);
	enableMux: mux_2to1_top
	PORT MAP (
		A => int_final_q,
		B => i_d,
		SEL => i_enable,
		X => int_mux_d
	);

	-- Concurrent Signal Assignment
	int_q_or_async <= (int_q or i_async_set) and not i_async_reset;
	int_qBar_or_async <= int_qBar or i_async_reset;
	int_clock_or_async <= i_clock or i_async_set or i_async_reset;
	int_notD <= not(int_mux_d);
	int_notClock <= not(i_clock);
	o_q <= int_final_q;
END rtl;