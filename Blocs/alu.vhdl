LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity alu is
  port ( op1  : in  Std_Logic_Vector(31 downto 0);
         op2  : in  Std_Logic_Vector(31 downto 0);
         cin  : in  Std_Logic;
         cmd  : in  Std_Logic_Vector(1 downto 0);
         res  : out Std_Logic_Vector(31 downto 0);
         cout : out Std_Logic;
         z    : out Std_Logic;
         n    : out Std_Logic;
         v    : out Std_Logic;
         vdd  : in  bit;
         vss  : in  bit );
  end alu;

architecture Behavior of alu is

component adder is
 port    (op2 : in Std_Logic_Vector(31 downto 0);
	 op1 : in Std_Logic_Vector(31 downto 0);
	 cin : in Std_Logic;
	 cout : in Std_Logic;
	 ov : in Std_Logic;
	 res : out Std_Logic_Vector(31 downto 0));
end adder;
	
signal result : Std_Logic_Vector(31 downto 0);
	
begin
	process(cmd,op1,op2,cin)
	begin	
		cout <= cin;
		v <= "0";
		case cmd is 
			when "11" =>
				c1 : adder port map(op1 => op1, op2 => op2, cin => cin, result => res, cout => cout , v => ov);
			when "10" =>
				result <= op1 xor op2;
			when "01" =>
				result <= op1 and op2;
			when "00" =>
				result <= op1 or op2;
			when others =>
				result <= X"00000000";
		end case;
		
		if result = X"00000000"
		then
			z <= '1';
		else
			z <= '0';
		end if;
		
		if result(31) = '1'
		then
			n <= '1';
		else
			n <= '0';
		end if;
		
	end process;
end Behavior;
			
			
