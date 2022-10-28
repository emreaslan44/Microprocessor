

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX is
 generic(
         numberOfBits : integer := 32
         );
  Port (
        A : in std_logic_vector(numberOfBits-1 downto 0);
        B : in std_logic_vector(numberOfBits-1 downto 0);
        sel : in std_logic;
        MUX_out : out std_logic_vector(numberOfBits-1 downto 0)
        );
end MUX;

architecture Behavioral of MUX is


begin


MUX_32 : process (A,B,sel) begin

case sel is 

    when '0' => MUX_out <= A;
    
    when '1' => MUX_out <= B;
    
    when others => MUX_out <= (others => '0');
    
end case;

end process;




end Behavioral;
