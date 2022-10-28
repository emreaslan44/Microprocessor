----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2021 02:58:45 PM
-- Design Name: 
-- Module Name: one_bit_Comp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity oneBitComp is
Port (A,B,Gin,Lin,Ein : in std_logic;
      Lout,Gout,Eout : out std_logic
         );
end oneBitComp;

architecture Behavioral of oneBitComp is

begin

Gout <= (not(B) and Gin) or (A and not(B)) or (A and Gin);
Lout <= (not(A) and Lin) or (not(A) and B) or (B and Lin);
Eout <= (not(A) and not(B) and not(Gin) and not(Lin)) or (A and B and not(Gin) and not(Lin)) ;

end Behavioral;
