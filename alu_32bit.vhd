library ieee;
use ieee.std_logic_1164.all;

entity alu_32bit is
    port(
        a_in        : in std_logic_vector(31 downto 0);
        b_in        : in std_logic_vector(31 downto 0);
        sel         : in std_logic_vector(2 downto 0);
        alu_result  : out std_logic_vector(31 downto 0);
        zero_flag   : out std_logic
    );
end alu_32bit;

architecture structural of alu_32bit is
    component mux8to1_32bit is
        port(
            sel     : in std_logic_vector(2 downto 0);
            d_in0   : in std_logic_vector(31 downto 0);
            d_in1   : in std_logic_vector(31 downto 0);
            d_in2   : in std_logic_vector(31 downto 0);
            d_in3   : in std_logic_vector(31 downto 0);
            d_in4   : in std_logic_vector(31 downto 0);
            d_in5   : in std_logic_vector(31 downto 0);
            d_in6   : in std_logic_vector(31 downto 0);
            d_in7   : in std_logic_vector(31 downto 0);
            d_out   : out std_logic_vector(31 downto 0)
        );
    end component;

    component cla_32bit is
        port(
            a_in            :   in std_logic_vector(31 downto 0);
            b_in            :   in std_logic_vector(31 downto 0);
            c_in            :   in std_logic;
            sum_out         :   out std_logic_vector(31 downto 0);
            c_out           :   out std_logic;
            zero_flag       :   out std_logic;
            overflow_flag   :   out std_logic
        );
    end component;

    signal and_int, or_int, add_int, subtract_int   : std_logic_vector(31 downto 0);
    signal not_b_in                                 : std_logic_vector(31 downto 0);
    signal or_chain                                 : std_logic_vector(31 downto 0);
	 signal alu_result_int									 : std_logic_vector(31 downto 0);
	
    begin
    cla_adder: cla_32bit
        port map(
            a_in            => a_in,
            b_in            => b_in,
            c_in            => '0',
            sum_out         => add_int,
            c_out           => open,
            zero_flag       => open,
            overflow_flag   => open
        );
    
    not_b_in <= NOT(b_in);
    cla_subtractor: cla_32bit
        port map(
            a_in            => a_in,
            b_in            => not_b_in,
            c_in            => '1',
            sum_out         => subtract_int,
            c_out           => open,
            zero_flag       => open,
            overflow_flag   => open
        );
    
    and_int <= a_in AND b_in;
    or_int <= a_in OR b_in;
    
    operation_mux: mux8to1_32bit
        port map(
            sel     => sel,
            d_in0   => and_int,
            d_in1   => or_int,
            d_in2   => add_int,
            d_in3   => (others => '0'),
            d_in4   => (others => '0'),
            d_in5   => (others => '0'),
            d_in6   => subtract_int,
            d_in7   => (others => '0'),
            d_out   => alu_result_int
        );

    or_chain(0) <= alu_result_int(0);
    gen_or_chain: for i in 1 to 31 generate
        or_chain(i) <= or_chain(i-1) OR alu_result_int(i);
    end generate;
    zero_flag <= NOT(or_chain(31));
	 alu_result <= alu_result_int;
end structural;