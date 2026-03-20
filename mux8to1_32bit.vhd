library ieee;
use ieee.std_logic_1164.all;

entity mux8to1_32bit is
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
end mux8to1_32bit;

architecture structural of mux8to1_32bit is
    signal not_sel    : std_logic_vector(2 downto 0);       -- Complemented select signal value.
    signal selected   : std_logic_vector(7 downto 0);       -- MUX's choice.

    signal sel_in0    : std_logic_vector(31 downto 0);      -- Intermediate value to check if d_in0 was selected.
    signal sel_in1    : std_logic_vector(31 downto 0);      
    signal sel_in2    : std_logic_vector(31 downto 0);     
    signal sel_in3    : std_logic_vector(31 downto 0);     
    signal sel_in4    : std_logic_vector(31 downto 0);      
    signal sel_in5    : std_logic_vector(31 downto 0);     
    signal sel_in6    : std_logic_vector(31 downto 0);     
    signal sel_in7    : std_logic_vector(31 downto 0);     

    begin
    gen_not: for i in 0 to 2 generate
        not_sel(i) <= NOT(sel(i));
    end generate;

    selected(0) <= not_sel(2) AND not_sel(1) AND not_sel(0);
    selected(1) <= not_sel(2) AND not_sel(1) AND     sel(0);
    selected(2) <= not_sel(2) AND     sel(1) AND not_sel(0);
    selected(3) <= not_sel(2) AND     sel(1) AND     sel(0);
    selected(4) <=     sel(2) AND not_sel(1) AND not_sel(0);
    selected(5) <=     sel(2) AND not_sel(1) AND     sel(0);
    selected(6) <=     sel(2) AND     sel(1) AND not_sel(0);
    selected(7) <=     sel(2) AND     sel(1) AND     sel(0);
    
    gen_sel0: for i in 0 to 31 generate
        sel_in0(i) <= d_in0(i) AND selected(0);
    end generate;

    gen_sel1: for i in 0 to 31 generate
        sel_in1(i) <= d_in1(i) AND selected(1);
    end generate;
    
    gen_sel2: for i in 0 to 31 generate
        sel_in2(i) <= d_in2(i) AND selected(2);
    end generate;
    
    gen_sel3: for i in 0 to 31 generate
        sel_in3(i) <= d_in3(i) AND selected(3);
    end generate;

    gen_sel4: for i in 0 to 31 generate
        sel_in4(i) <= d_in4(i) AND selected(4);
    end generate;

    gen_sel5: for i in 0 to 31 generate
        sel_in5(i) <= d_in5(i) AND selected(5);
    end generate;

    gen_sel6: for i in 0 to 31 generate
        sel_in6(i) <= d_in6(i) AND selected(6);
    end generate;

    gen_sel7: for i in 0 to 31 generate
        sel_in7(i) <= d_in7(i) AND selected(7);
    end generate;
    
    gen_output: for i in 0 to 31 generate
        d_out(i) <= sel_in0(i) OR sel_in1(i) OR sel_in2(i) OR sel_in3(i) OR sel_in4(i) OR sel_in5(i) OR sel_in6(i) OR sel_in7(i);
    end generate;

end structural;