LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity adder is
port    (op2 : in Std_Logic_Vector(31 downto 0);
         op1 : in Std_Logic_Vector(31 downto 0);
	 cin : in Std_Logic;
	 ov  : out Std_Logic;
	 cout: out Std_Logic;
         res : out Std_Logic_Vector(31 downto 0));
end adder;

architecture arch of adder is

        signal gi : Std_Logic_Vector(31 downto 0);
        signal pi : Std_Logic_Vector(31 downto 0);


        signal g0 : Std_Logic_Vector(31 downto 0);
        signal p0 : Std_Logic_Vector(31 downto 0);

        signal g1 : Std_Logic_Vector(31 downto 0);
        signal p1 : Std_Logic_Vector(31 downto 0);

        signal g2 : Std_Logic_Vector(31 downto 0);
        signal p2 : Std_Logic_Vector(31 downto 0);

        signal g3 : Std_Logic_Vector(31 downto 0);
        signal p3 : Std_Logic_Vector(31 downto 0);

        signal g4 : Std_Logic_Vector(31 downto 0);
        signal p4 : Std_Logic_Vector(31 downto 0);

        signal s_out : Std_Logic_Vector(31 downto 0);
	signal c_out : Std_Logic_Vector(31 downto 0);
begin
        gi <= a and b;
        pi <= a xor b;

        g0 <= gi or (pi and (gi(30 downto 0) & cin));
        p0 <= pi and ( pi(30 downto 0) & B"1");

        g1 <= g0 or (p0 and (g0(29 downto 0) & B"0" & cin));
        p1 <= p0 and ( p0(29 downto 0) & B"11");

        g2 <= g1 or (p1 and (g1(27 downto 0) & B"000" & cin));
        p2 <= p1 and ( p1(27 downto 0) & X"F");

        g3 <= g2 or (p2 and (g2(23 downto 0) & B"0000000" & cin));
        p3 <= p2 and ( p2(23 downto 0) & X"FF");

        g4 <= g3 or (p3 and (g3(15 downto 0) & X"000" & B"000" & cin));
        p4 <= p3 and ( p3(15 downto 0) & X"FFFF");

        c_out <= g4;
        s_out <= pi xor (c_out(30 downto 0) & B"0");

	cout <= c_out(31);
	ov <= c_out(31) xor c_out(30);
	res <= s_out;
end arch;
