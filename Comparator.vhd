
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Comparator is
generic(
        numberOfBits : integer := 32
        );

 Port  ( 
        first_numb : in std_logic_vector(numberOfBits-1 downto 0)  := (others => '0');
        second_numb : in std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
        LsResult : out std_logic;
        EqResult : out std_logic
        );
end Comparator;

architecture Behavioral of Comparator is


component oneBitComp is
Port (A,B,Gin,Lin,Ein : in std_logic;
      Lout,Gout,Eout : out std_logic
         );
end component;

signal Gouts : std_logic_vector(numberOfBits downto 0) := (others => '0');
signal Louts : std_logic_vector(numberOfBits downto 0):= (others => '0');
signal Eouts :std_logic_vector(numberOfBits downto 0):= (others => '0');

begin

m_bit_comp : for i in 0 to numberOfBits-1 generate

comp: oneBitComp 
Port Map(A => first_numb(i), B=> second_numb(i), Gin => Gouts(i+1), Lin => Louts(i+1), Ein => Eouts(i+1), Lout => Louts(i), Gout => Gouts(i), Eout => Eouts(i));

end generate;

LsResult <= Louts(numberOfBits);
EqResult <= Eouts(numberOfBits);

end Behavioral;
