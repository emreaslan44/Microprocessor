
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SignExtension is
generic(
        numberOfBits : integer := 32
        );

  Port (inp_sign : in std_logic_vector(numberOfBits/2 -1 downto 0);
        out_sign : out std_logic_vector(numberOfBits -1 downto 0)
        );
        
end SignExtension;

architecture Behavioral of SignExtension is

begin

process (inp_sign) begin

    case inp_sign(15) is
    
        when '0' => out_sign <=  (numberOfBits/2 -1 downto 0 => '0') & inp_sign ;
        
        when '1' => out_sign <=  (numberOfBits/2 -1 downto 0 => '1') & inp_sign ;
        
        when others =>  out_sign <= (numberOfBits -1 downto 0 => '0');
    
    end case;
end process;


end Behavioral;
