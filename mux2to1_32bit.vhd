library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_32bit is
    port(
        sel     :   in std_logic;
        d_in0   :   in std_logic_vector(31 downto 0);
        d_in1   :   in std_logic_vector(31 downto 0);
        d_out   :   out std_logic_vector(31 downto 0)
    );
end mux2to1_32bit;

architecture structural of mux2to1_32bit is
    signal not_sel  : std_logic;
    signal sel_in0  : std_logic_vector(31 downto 0);
    signal sel_in1  : std_logic_vector(31 downto 0);

    begin
    not_sel <= NOT(sel);

    loop0: for i in 0 to 31 generate
        sel_in0(i) <= d_in0(i) AND not_sel;
    end generate;

    loop1: for i in 0 to 31 generate
        sel_in1(i) <= d_in1(i) AND sel;
    end generate;

    loop2: for i in 0 to 31 generate
        d_out(i) <= sel_in0(i) OR sel_in1(i);
    end generate;
end structural;