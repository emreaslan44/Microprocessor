

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ProgramCounter is

generic(numberOfBits : integer := 32
        );

  Port ( 
        address : in std_logic_vector(numberOfBits-1 downto 0);
        reset : in std_logic;
        clk : in std_logic;
        PCresult : out std_logic_vector (numberOfBits -1 downto 0)
        );
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin


process (clk,reset,address) begin

    if (rising_edge(clk)) then
        if (reset = '1') then
            PCresult <= (numberOfBits-1 downto 0 => '0'); 
        else
            PCresult <= address;
        end if;
    end if;

end process;


end Behavioral;
