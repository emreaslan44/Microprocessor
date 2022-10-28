library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_signed.all;




entity ALU is

generic
        (numberOfBits : integer := 32
        );
        
 Port (ALU_Control : in std_logic_vector(3 downto 0);
       A : in std_logic_vector(numberOfBits-1 downto 0);
       B : in std_logic_vector(numberOfBits-1 downto 0);
       ALU_Result : out std_logic_vector(numberOfBits-1 downto 0);
       ZERO: out std_logic
        );
end ALU;



architecture Behavioral of ALU is





----For ALU----
signal ALUResult : std_logic_vector(numberOfBits-1 downto 0);




--- Left-Rift Shifters---
signal A_copy : std_logic_vector(2*numberOfBits-1 downto 0 ) := (others => '0') ;
signal B_int : integer  := to_integer(unsigned(B));




begin


main :process (ALU_Control,A,B,ALUResult,B_int,A_copy)
VARIABLE counter: INTEGER RANGE 0 TO numberOfBits := 0; 

 begin


    case ALU_Control is
    
    when "0000" =>
        ALUResult  <=  A + B ;

    
    when "0001" =>
        ALUResult  <=  A - B ;
 

    when "0010" =>
        ALUResult <= std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))),numberOfBits)); 
    when "0011" =>
        ALUResult <= A and B;
    
    when "0100" =>
        ALUResult <= A or B; 
    when "0101" =>
               if (A < B) then
                    ALUResult <= "00000000000000000000000000000001";
               else
                    ALUResult <= "00000000000000000000000000000000";
                end if;    
    when "0110" =>  
               if (A = B) then
                    ALUResult <= "00000000000000000000000000000001";
               else
                    ALUResult <= "00000000000000000000000000000000";
                end if;
    when "0111" =>
               if (A = B) then
                    ALUResult <= "00000000000000000000000000000000";
               else
                    ALUResult <= "00000000000000000000000000000001";
                end if;
 
    when "1000" =>
           if(to_integer(unsigned(B))<=32) then
              B_int <= to_integer(unsigned(B));
               A_copy <= A &(numberOfBits-1 downto 0 => '0') ;
                ALUResult <= A_copy(2*numberOfBits-1-B_int downto numberOfBits-B_int);
            --ALUResult <= A(numberOfBits-1-B_int downto 0) &(B_int-1 downto 0 => '0') ;
            else  
                ALUResult <= (others => '0');
            end if;
   
    when "1001" =>
        if(to_integer(unsigned(B))<=32) then
            B_int <= to_integer(unsigned(B));
          A_copy <= (numberOfBits-1 downto 0 => '0') & A;
           ALUResult <= A_copy(numberOfBits-1+ B_int downto B_int );
         --- ALUResult <=  (B_int-1 downto 0 => '0') & A(numberOfBits-1 downto B_int);
        else
            ALUResult <= (others => '0') ;
        end if;
                
    when "1010" =>
           A_copy <= A & A;
            ALUResult <= A_copy(numberOfBits-1+ B_int downto B_int );
         ---ALUResult <= A(numberOfBits-1- B_int downto 0) & A(numberOfBits-1 downto numberOfBits-B_int );
            
    when "1011" =>
    FOR i IN 0 to numberOfBits-1 LOOP
CASE A(i) IS
 WHEN '1' => counter := counter +1;

 WHEN OTHERS => next;
 END CASE; 

 END LOOP;
  ALUResult <= std_logic_vector(to_unsigned((counter),numberOfBits)); 
    counter := 0;
   
    when "1100" =>
        FOR i IN 0 to numberOfBits-1 LOOP
         CASE A(i) IS
             WHEN '0' => counter := counter +1;
             WHEN OTHERS => next;
         END CASE; 
         END LOOP;
  ALUResult <= std_logic_vector(to_unsigned((counter),numberOfBits)); 
 counter := 0;
    
    
    when others => ALUResult <= (numberOfBits-1 downto 0 => '0'); 
    end case;
 

end process;


zeroProcess : process(ALUResult)begin 
    if(ALUResult = "00000000000000000000000000000000") then
    ZERO <= '1';
    else
    ZERO <= '0';
    end if;
end process;


ALU_result <= ALUResult;



end Behavioral;
