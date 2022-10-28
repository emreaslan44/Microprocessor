
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftOPMux is
generic(
        numberOfBits : integer := 32
        );
        
 Port (
        readData1 : in std_logic_vector(numberOfBits-1 downto 0);
        readData2 : in std_logic_vector(numberOfBits-1 downto 0);
        ALU_OP : in std_logic_vector(3 downto 0);
        readData1_out : out std_logic_vector(numberOfBits-1 downto 0)
        );
end ShiftOPMux;

architecture Behavioral of ShiftOPMux is

begin

process (readData1,readData2,ALU_OP) begin

    if (ALU_OP = "1000") or  (ALU_OP = "1001") then  ---left shift and right shift
    
        readData1_out <= readData2;
    else
        readData1_out  <= readData1;
    
    end if;


end process;


end Behavioral;
