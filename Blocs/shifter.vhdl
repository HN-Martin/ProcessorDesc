library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
    port
    (
        shift_lsl : in  Std_Logic;
        shift_lsr : in  Std_Logic;
        shift_asr : in  Std_Logic;
        shift_ror : in  Std_Logic;
        shift_rrx : in  Std_Logic;

        shift_val : in  Std_Logic_Vector(4 downto 0);
        din       : in  Std_Logic_Vector(31 downto 0);
        cin       : in  Std_Logic;

        dout      : out Std_Logic_Vector(31 downto 0);
        cout      : out Std_Logic;

        -- global interface
        vdd       : in  bit;
        vss       : in  bit
    );
end shifter;

architecture archi of shifter is
signal shift_cat : std_logic_vector(4 downto 0) := (others => '0');
signal u_shift_val : integer := 0;
begin
    shift_cat <= shift_lsl & shift_lsr & shift_asr & shift_ror & shift_rrx;
    process (shift_cat, shift_val)

    function logic_vector_to_int (v : in std_logic_vector) return integer is
    variable sum : integer;
    variable puis : integer;
    begin
        sum := 0;
        puis := 1;
        L1 : for i in 0 to 4 loop
            if v(i) = '1' then
                sum := sum + puis;
            end if;
            puis := puis*2;
        end loop L1;
        return sum;
    end function logic_vector_to_int;

    begin
    u_shift_val <= logic_vector_to_int(shift_val);
    if u_shift_val = 0
    then
        cout <= cin;
        dout <= din;
    else
        case shift_cat is
            -- lsl
            when "10000" =>
                dout <= (others => '0');
                dout (31 downto u_shift_val) <= din((31-u_shift_val) downto 0);
                cout <= din(31-u_shift_val+1);

            -- lsr
            when "01000" =>
                dout <= (others => '0');
                dout((31-u_shift_val) downto 0) <= din(31 downto u_shift_val);
                cout <= din(u_shift_val-1);

            -- asr
            when "00100" =>
                if din(31) = '1'
                then
                    dout <= (others => '1');
                else
                    dout <= (others => '0');
                end if;

                dout((31-u_shift_val) downto 0) <= din(31 downto u_shift_val);
                cout <= din(u_shift_val-1);

            -- ror
            when "00010" =>
                dout((31-u_shift_val) downto 0) <= din(31 downto u_shift_val);
                dout(31 downto (31-u_shift_val+1)) <= din((u_shift_val-1) downto 0);
                cout <= din(u_shift_val-1);
                

            -- rrx
            when others =>
                dout(30 downto 0) <= din(31 downto 1);
                dout(31) <= cin;
                cout <= din(0);
        end case;
    end if;
    end process;
end archi;


