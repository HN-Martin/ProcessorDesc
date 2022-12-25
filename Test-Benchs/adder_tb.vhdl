library ieee;
use ieee.std_logic_1164.all;

LIBRARY ieee
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY adder4_bench IS
END adder4_bench;

ARCHITECTURE behavior OF adder4_bench IS 

-- Component Declaration for the Unit Under Test (UUT)

COMPONENT adder4
PORT(
     i0 : IN  unsigned(3 downto 0);
     i1 : IN  unsigned(3 downto 0);
     Cin: IN  STD_LOGIC;	
     sum : OUT unsigned(3 downto 0);
     Cout : OUT STD_LOGIC
    );
END COMPONENT;


--Inputs
signal i0 : unsigned(3 downto 0) := (others => '0');
signal i1 : unsigned(3 downto 0) := (others => '0');
signal Cin : STD_LOGIC;

--Outputs
signal sum : unsigned(3 downto 0);
signal Cout : STD_LOGIC;
-- No clocks detected in port list. Replace <clock> below with 
-- appropriate port name 

--constant <clock>_period : time := 10 ns;

BEGIN

-- Instantiate the Unit Under Test (UUT)
uut: adder4 PORT MAP (
      i0,
      i1,
      Cin, 
      sum,
      Cout
    );

stim_proc: process
begin       
        i0 <= "0000";
        i1 <= "0000";
	Cin <= '0';
        wait for 10 ns;
        assert ( sum = "0000" )report "Failed Case 11 - Ans" severity error;
        assert ( Cout = '0' )   report "Failed Case 1 - Cout" severity error;
        wait for 10 ns;



	i0 <= "0000";
        i1 <= "0001";
	Cin <= '1';
        wait for 10 ns;
        assert ( sum = "0010" )report "Failed Case 12 - Ans" severity error;
        assert ( Cout = '0' )   report "Failed Case 1 - Cout" severity error;
        wait for 10 ns;


	i0 <= "1000";
        i1 <= "0001";
	Cin <= '1';
        wait for 10 ns;
        assert ( sum = "1010" )report "Failed Case 13 - Ans" severity error;
        assert ( Cout = '0' )   report "Failed Case 1 - Cout" severity error;
        wait for 10 ns;

	i0 <= "1111";
        i1 <= "0100";
	Cin <= '0';
        wait for 10 ns;
        assert ( sum = "0011" )report "Failed Case 14 - Ans" severity error;
        assert ( Cout = '1' )   report "Failed Case 1 - Cout" severity error;
        wait for 10 ns;


    -- Case 2 that we are testing.

        i0 <= "1111";
        i1 <= "1111";
	Cin <= '0';
        wait for 10 ns;
        assert ( sum = "1110" )report "Failed Case 25 - Ans" severity error;
        assert ( Cout = '1' )   report "Failed Case 2 - Cout" severity error;
        wait for 10 ns;



  wait;
 end process;

 END;

