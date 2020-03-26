--------------------------------------------------------------------------------
-- LFSR pseudorandom number generator
--------------------------------------------------------------------------------
-- SETTINGS
--    * Length = <lfsrLen>
--    * Tap list = <tapList>
--    * Iterations / clk cycles = <lfsrIter>
-- 
--------------------------------------------------------------------------------
-- IMPLEMENTATION EXAMPLE
-- Schematic for a single iteration on a 8 bit LFSR with tap list = [7, 6, 5, 4].
--        
--            ___   ___   ___   ___   ___   ___   ___
--           |   | |   | |   | |   | |   | |   | |   | 
--               v     v     v     v     v     v     v 
--         |0|   |1|   |2|   |3|   |4|   |5|   |6|   |7| 
--          ^   ___ ________________|     |     |     |
--          |  |   |______________________|     |     |
--          |__|XOR|____________________________|     |
--             |___|__________________________________|
--
--
-- Pau Gomez (c) pau.gomez@dspsandbox.org
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr is
    Generic(
        lfsrLen : integer: <lfsrLen>;
        lfsrIter : integer: <lfsrIter>
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
    signal sr : std_logic_vector ((lfsrLen-1) downto 0) := (others=>'0')
    begin
        process(clk)
            begin
                if rising_edge(clk):
                    if reset='1' then
                        sr <= seedIn;
                    else
                        if en='1' then
<xorList>
                        end if;
                    end if;
                end if;
        end process;

        rndOut <= sr((lfsrIter-1) downto 0);
end Behavioural;
