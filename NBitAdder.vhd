
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
---use IEEE.std_logic_arith.ALL;
--use IEEE.std_logic_unsigned.ALL;


entity NBitAdder is
generic(
        numberOfBits : integer := 32
        );
        
 Port  ( 
        first_numb : in std_logic_vector(numberOfBits-1 downto 0)  := (others => '0');
        second_numb : in std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
        SUM : out std_logic_vector (numberOfBits-1 downto 0)
        );
end NBitAdder;

architecture Behavioral of NBitAdder is

 component FullAdder is  
   port( 
  X1, X2, Cin : in std_logic;  
  S, Cout_FULL : out std_logic
  );  
 end component;  

signal C_outputs : std_logic_vector(numberOfBits downto 0) := (others => '0');


begin



 m_bit_adder : for i in 0 to numberOfBits-1 generate

dd_i: FullAdder 
        port map(first_numb(i), 
                 second_numb(i), 
                 C_outputs(i), 
                 SUM(i), 
                 C_outputs(i+1)
                  );
end generate;



end Behavioral;
