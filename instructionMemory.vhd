library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;



entity instructionMemory is
generic(
        numberOfBits : integer := 32 
        );
 Port ( 
        clk : in std_logic;
        readAddress : in std_logic_vector(numberOfBits-1 downto 0);
        instruction : out std_logic_vector(numberOfBits-1 downto 0)   
        );
        
end instructionMemory;

architecture Behavioral of instructionMemory is

type mem_type is array (0 to numberofBits/2-1) of std_logic_vector(numberofBits-1 downto 0);
signal inst_mem: mem_type := (
                             0 => x"2010000e",
                             1 => x"2011000f",
                             2 => x"2012001d",
                             3 =>x"2013fff1",
                             4=> x"02324020",
                             5=> x"02504024",
                             6=> x"72114002",
                             7=> x"02504025",
                             8=> x"36080010",
                             9=> x"02124022",
                             10=> x"72604021",
                             11 => x"72404020",
                             12 => x"0211402a",
                             13 => x"0230402a",
                             14 => x"00114080",
                             15 => x"001240c2",
                            others => (others => '0' ));

begin

---- Read Process--
read_inst : process (readAddress,clk) begin
if (rising_edge(clk)) then
 --  if(to_integer(unsigned(readAddress))/4<numberOfBits/2) then
        instruction <= inst_mem(to_integer(unsigned(readAddress(8 downto 2))));
 ---  else
 ---     instruction <=  (others => '0');

end if;
--end if;

end process;


end Behavioral;
