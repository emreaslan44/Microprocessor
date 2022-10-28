library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_signed.all;

entity PcAdder is

generic(
        numberOfBits : integer := 32
        );
Port (PCResult: in std_logic_vector(numberOfBits-1 downto 0);
      PCAddResult : out std_logic_vector(numberOfBits-1 downto 0)
      );
end PcAdder;



architecture Behavioral of PcAdder is




begin



process (PCResult) begin
case PCResult is
when "11111111111111111111111111111111" => PCAddResult <= (numberOfBits-3 downto 0 => '0') & "11";

when "11111111111111111111111111111110" => PCAddResult <= (numberOfBits-3 downto 0 => '0') & "10";

when "11111111111111111111111111111100" => PCAddResult <= (numberOfBits-2 downto 0 => '0') & '1';

when "11111111111111111111111111111011" => PCAddResult <= (numberOfBits-1 downto 0 => '0');

when others =>  PCAddResult <= "00000000000000000000000000000100" + PCResult;

end case;

end process;

end Behavioral;
