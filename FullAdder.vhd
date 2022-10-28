 library ieee; 
 use ieee.std_logic_1164.all;  
 
 entity FullAdder is  
   port( 
  X1, X2, Cin : in std_logic;  
  S, Cout_FULL : out std_logic
  );  
 end FullAdder;  

 architecture structural of FullAdder is  

 begin  
   Cout_FULL <= (X1 and X2) or ((X1 xor X2) and Cin);  
   S <= (X1 xor X2) xor Cin;  
 end structural;  