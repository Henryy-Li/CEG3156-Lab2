library ieee;
use ieee.std_logic_1164.all;

entity cla_32bit is
    port(
        a_in            :   in std_logic_vector(31 downto 0);
        b_in            :   in std_logic_vector(31 downto 0);
        c_in            :   in std_logic;
        sum_out         :   out std_logic_vector(31 downto 0);
        c_out           :   out std_logic;
        zero_flag       :   out std_logic;
        overflow_flag   :   out std_logic
    );
end cla_32bit;

architecture structural of cla_32bit is
    component cla_8bit is
        port(
            a_in            :   in std_logic_vector(7 downto 0);
            b_in            :   in std_logic_vector(7 downto 0);
            c_in            :   in std_logic;
            sum_out         :   out std_logic_vector(7 downto 0);
            c_out           :   out std_logic;
            zero_flag       :   out std_logic;
            overflow_flag   :   out std_logic
        );
    end component;

    signal carry_int        : std_logic_vector(4 downto 0);
    signal sum_int          : std_logic_vector(31 downto 0);
    signal zero_flag_int    : std_logic_vector(3 downto 0);
    signal overflow_flag_int: std_logic_vector(3 downto 0);

    begin
    carry_int(0) <= c_in;

    CLA0: cla_8bit
        port map(
            a_in            => a_in(7 downto 0),
            b_in            => b_in(7 downto 0),
            c_in            => carry_int(0),
            sum_out         => sum_int(7 downto 0),
            c_out           => carry_int(1),
            zero_flag       => zero_flag_int(0),
            overflow_flag   => overflow_flag_int(0)
        );
    
    CLA1: cla_8bit
        port map(
            a_in            => a_in(15 downto 8),
            b_in            => b_in(15 downto 8),
            c_in            => carry_int(1),
            sum_out         => sum_int(15 downto 8),
            c_out           => carry_int(2),
            zero_flag       => zero_flag_int(1),
            overflow_flag   => overflow_flag_int(1)
        );
    
    CLA2: cla_8bit
        port map(
            a_in            => a_in(23 downto 16),
            b_in            => b_in(23 downto 16),
            c_in            => carry_int(2),
            sum_out         => sum_int(23 downto 16),
            c_out           => carry_int(3),
            zero_flag       => zero_flag_int(2),
            overflow_flag   => overflow_flag_int(2)
        );
    
    CLA3: cla_8bit
        port map(
            a_in            => a_in(31 downto 24),
            b_in            => b_in(31 downto 24),
            c_in            => carry_int(3),
            sum_out         => sum_int(31 downto 24),
            c_out           => carry_int(4),
            zero_flag       => zero_flag_int(3),
            overflow_flag   => overflow_flag_int(3)
        );
    
    sum_out <= sum_int;
    c_out <= carry_int(4);
    zero_flag <= zero_flag_int(0) AND zero_flag_int(1) AND zero_flag_int(2) AND zero_flag_int(3);
    overflow_flag <= overflow_flag_int(3);
end structural;