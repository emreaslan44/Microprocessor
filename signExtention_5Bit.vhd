
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity signExtention_5Bit is
generic(shiftBit : integer := 5;
        numberOfBits : integer :=32
        );

 Port (shifAmnt : in std_logic_vector(shiftBit -1 downto 0) ;
       shiftLarge : out std_logic_vector(numberOfBits -1 downto 0) 
        );
end signExtention_5Bit;


architecture Behavioral of signExtention_5Bit is

begin

shiftLarge <= (numberOfBits-shiftBit-1  downto 0 => '0') & shifAmnt;




end Behavioral;
