--------------------------------------------------------------------------------
-- LFSR pseudorandom number generator
-- Pau Gomez (c) pau.gomez@dspsandbox.org
--------------------------------------------------------------------------------
-- SETTINGS
--    * Length = 8
--    * Tap list = [7, 5, 4, 3]
--    * Iterations / clk cycle = 8
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr is
    Generic(
        lfsrLen : integer := 8;
        lfsrIter : integer := 8
        );
    Port(
        clk : in std_logic;
        reset : in std_logic;
        en : in std_logic;
        seedIn : in std_logic_vector((lfsrLen-1) downto 0);
        rndOut : out std_logic_vector((lfsrIter-1) downto 0)
        );

end lfsr;

architecture Behavioural of lfsr is
    signal sr : std_logic_vector ((lfsrLen-1) downto 0) := (others=>'0');
    begin
        process(clk)
            begin
                if rising_edge(clk) then
                    if reset='1' then
                        sr <= seedIn;
                    else
                        if en='1' then
sr(0) <= sr(2) xor sr(5) xor sr(6);
sr(1) <= sr(3) xor sr(6) xor sr(7);
sr(2) <= sr(0) xor sr(5) xor sr(6) xor sr(7);
sr(3) <= sr(0) xor sr(1) xor sr(4) xor sr(5) xor sr(7);
sr(4) <= sr(0) xor sr(1) xor sr(2) xor sr(4);
sr(5) <= sr(1) xor sr(2) xor sr(3) xor sr(5);
sr(6) <= sr(2) xor sr(3) xor sr(4) xor sr(6);
sr(7) <= sr(3) xor sr(4) xor sr(5) xor sr(7);

                        end if;
                    end if;
                end if;
        end process;

        rndOut <= sr((lfsrIter-1) downto 0);
end Behavioural;
