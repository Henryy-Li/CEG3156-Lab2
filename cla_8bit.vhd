library ieee;
use ieee.std_logic_1164.all;

entity cla_8bit is
    port(
        a_in            :   in std_logic_vector(7 downto 0);
        b_in            :   in std_logic_vector(7 downto 0);
        c_in            :   in std_logic;
        sum_out         :   out std_logic_vector(7 downto 0);
        c_out           :   out std_logic;
        zero_flag       :   out std_logic;
        overflow_flag   :   out std_logic
    );
end cla_8bit;

architecture structural of cla_8bit is
    signal g   		    :   std_logic_vector(7 downto 0);
    signal p   		    :   std_logic_vector(7 downto 0);
    signal c    		:   std_logic_vector(7 downto 0);
	signal sum_out_int  :   std_logic_vector(7 downto 0);
	signal not_sum_out  :   std_logic_vector(7 downto 0);
	
    begin
    loop0: for i in 0 to 7 generate
        g(i) <= a_in(i) AND b_in(i);
    end generate;

    loop1: for i in 0 to 7 generate
        p(i) <= a_in(i) OR b_in(i);
    end generate;

    c(0) <= c_in;
    loop2: for i in 1 to 7 generate
        c(i) <= g(i-1) OR (p(i-1) AND c(i-1));
    end generate;
    c_out <= g(7) OR (p(7) AND c(7));

    loop3: for i in 0 to 7 generate
        sum_out_int(i) <= (a_in(i) XOR b_in(i)) XOR c(i);
    end generate;

    not_sum_out <= NOT(sum_out_int);
    zero_flag <= not_sum_out(7) AND not_sum_out(6) AND not_sum_out(5) AND not_sum_out(4) AND not_sum_out(3) AND not_sum_out(2) AND not_sum_out(1) AND not_sum_out(0);
    
    overflow_flag <= (a_in(7) AND b_in(7) AND NOT(sum_out_int(7))) OR (NOT(a_in(7)) AND NOT(b_in(7)) AND sum_out_int(7));
	
    sum_out <= sum_out_int;
end structural;

    