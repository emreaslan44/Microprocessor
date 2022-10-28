

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_5Bit is

generic(
        numberOfBits : integer := 32
        );

 Port (input1_MUX5 : in std_logic_vector (numberOfBits-1 downto 0);
       input2_MUX5 : in std_logic_vector (numberOfBits-1 downto 0);
       input3_MUX5 : in std_logic_vector (numberOfBits-1 downto 0);
       sel : in std_logic_vector(1 downto 0);
       out_MUX5 : out std_logic_vector (numberOfBits-1 downto 0)
      );
      
end MUX_5Bit;

architecture Behavioral of MUX_5Bit is



begin

MUX_5B: process (input1_MUX5,input2_MUX5,sel,input3_MUX5) begin

case sel is 
    when "00" => out_MUX5 <=input1_MUX5;
    when "01" => out_MUX5 <=input2_MUX5;
    when "10" => out_MUX5 <=input3_MUX5;
    when others => out_MUX5 <= (others => '0');
    
end case;

end process;


end Behavioral;
