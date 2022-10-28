
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Controller is
 Port (
       OpCode : in std_logic_vector(5 downto 0);
       Func : in std_logic_vector(5 downto 0);
       ALUSrc : out std_logic_vector(1 downto 0);
       RegDst,RegWrite : out std_logic;
       ALUOp : out std_logic_vector(3 downto 0);
       MemRead, MemWrite, MemtoReg,PCSrc : out std_logic
       );
end Controller;



architecture Behavioral of Controller is



begin




process (OpCode,Func) begin


-- Add
if ( OpCode = "000000" and Func ="100000") then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "0000";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

--Substraction
elsif (OpCode = "000000" and Func ="100010") then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "0001";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

-- And
elsif (OpCode = "000000" and Func ="100100") then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "0011";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

-- Or
elsif (OpCode = "000000" and Func ="100101" ) then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "0100";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

--Set less than
elsif(OpCode = "000000" and Func ="101010") then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "0101";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

-- ShiftLeft
elsif (OpCode = "000000" and Func ="000000") then
ALUSrc <= "10"; RegDst<= '0'; RegWrite <='1';
ALUOp <= "1000";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

-- ShiftRight
elsif ( OpCode = "000000" and Func ="000010") then
ALUSrc <= "10"; RegDst<= '0'; RegWrite <='1';
ALUOp <= "1001";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

-- Count Ones
elsif ( OpCode = "011100" and Func ="100001") then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "1011";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

-- Count Zeros
elsif (OpCode = "011100" and Func ="100000" ) then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "1100";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';


-- Multiplier
elsif ( OpCode = "011100" and Func ="000010") then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "0010";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';


-- RotateRight
elsif (OpCode = "000000" and Func ="000110") then
ALUSrc <= "00"; RegDst<= '1'; RegWrite <='1';
ALUOp <= "1010";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

--- Add imadiate
elsif( OpCode= "001000" ) then
ALUSrc <= "01"; RegDst<= '0'; RegWrite <='1';
ALUOp <= "0000";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';

---- Or imadiate
elsif( OpCode= "001101" ) then
ALUSrc <= "01"; RegDst<= '0'; RegWrite <='1';
ALUOp <= "0100";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';


else
ALUSrc <= "00"; RegDst<= '0'; RegWrite <='0';
ALUOp <= "0000";
MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0';
end if;

end process;




end Behavioral;
