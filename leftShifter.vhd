library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity leftShifter is

generic(numberOfBits : integer := 32);

  Port (
        left_in : in std_logic_vector(numberOfBits-1 downto 0);
        left_out : out std_logic_vector(numberOfBits-1 downto 0)
        );
end leftShifter;

architecture Behavioral of leftShifter is

begin
left_out <=  left_in(numberOfBits-3 downto 0) & "00";

end Behavioral;
