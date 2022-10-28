library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity DataMemoryUnit is
generic(
        numberOfBits : integer := 32
        );

  Port (
        Address : in std_logic_vector(numberOfBits-1 downto 0);
        writeData : in std_logic_vector(numberOfBits-1 downto 0);
        regWrite : std_logic;
        regRead : std_logic;
        clk : in std_logic;
        reset : in std_logic;
        readData : out std_logic_vector(numberOfBits-1 downto 0)
         );
end DataMemoryUnit;

architecture Behavioral of DataMemoryUnit is

type mem_type is array (0 to numberofBits/2-1) of std_logic_vector(numberofBits-1 downto 0);
signal DataMemory: mem_type :=(others => (others => '0') );
begin


---Write Operation---
write_main: process(clk) begin
    if (rising_edge(clk)) then
    
        if(regWrite = '1') then
        DataMemory(to_integer(unsigned(Address))) <= writeData;        
        end if;
    end if;
end process;

--- Read Operation ---
read_main: process(clk,reset) begin

    if (falling_edge(clk)) then
    
        if (reset = '1') then
            readData <= (numberofBits-1 downto 0 => '0');
        else
            if(regRead = '1') then
            readData <= DataMemory(to_integer(unsigned(Address)));
            else
            readData <= (numberofBits-1 downto 0 => '0');
            end if;
  
        end if;
        
    end if;
end process;

end Behavioral;
