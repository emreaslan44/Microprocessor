library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity RegisterFile is

generic(numberofBits : integer := 32
        );

 Port (
        clk,reset : in std_logic;
        readRegister1 : in std_logic_vector (4 downto 0);
        readRegister2 : in std_logic_vector (4 downto 0);
        regWrite : in std_logic;
        writeRegister : in std_logic_vector (4 downto 0);
        writeData : in std_logic_vector(numberofBits-1 downto 0);
        readData1 : out std_logic_vector (numberofBits-1 downto 0);
        readData2 : out std_logic_vector (numberofBits-1 downto 0)
       );
       
end RegisterFile;

architecture Behavioral of RegisterFile is

type mem_type is array (0 to numberofBits-1) of std_logic_vector(numberofBits-1 downto 0);
signal REG_FILE: mem_type := (16 => x"0000000E",
 others => (others => '0' ));

begin

---Write Operation---
write_main: process(clk) begin
    if (rising_edge(clk)) then
    
        if(regWrite = '1') then
        REG_FILE(to_integer(unsigned(writeRegister))) <= writeData;        
        end if;
    end if;
end process;


--- Read Operation ---

read_main: process(clk,reset) begin

    if (falling_edge(clk)) then
   
            if (reset = '1') then
                readData1 <= (numberofBits-1 downto 0 => '0');
                readData2 <= (numberofBits-1 downto 0 => '0');
            else
                readData1 <= REG_FILE(to_integer(unsigned(readRegister1)));
                readData2 <= REG_FILE(to_integer(unsigned(readRegister2)));    
                end if;
            end if;


end process;


end Behavioral;
