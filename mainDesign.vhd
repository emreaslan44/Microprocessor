library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mainDesign is
  generic(
         numberOfBits : integer := 32
         );
  
  Port (clk : in std_logic;
        reset : in std_logic;
        output : out std_logic_vector(numberOfBits -1 downto 0)
         );
         
end mainDesign;

architecture Behavioral of mainDesign is

component Controller is
 Port (
        
       OpCode : in std_logic_vector(5 downto 0);
       Func : in std_logic_vector(5 downto 0);
       ALUSrc : out std_logic_vector(1 downto 0);
       RegDst,RegWrite : out std_logic;
       ALUOp : out std_logic_vector(3 downto 0);
       MemRead, MemWrite, MemtoReg,PCSrc : out std_logic
       );
end component;




component PcAdder is
    generic(
            numberOfBits : integer := 32
            );
    Port (PCResult: in std_logic_vector(numberOfBits-1 downto 0);
          PCAddResult : out std_logic_vector(numberOfBits-1 downto 0)
          );
end component;


component signExtention_5Bit is
generic(shiftBit : integer := 5;
        numberOfBits : integer :=32
        );

 Port (shifAmnt : in std_logic_vector(shiftBit -1 downto 0) ;
       shiftLarge : out std_logic_vector(numberOfBits -1 downto 0) 
        );
end component;

component ShiftOPMux is
generic(
        numberOfBits : integer := 32
        );
        
 Port (
        readData1 : in std_logic_vector(numberOfBits-1 downto 0);
        readData2 : in std_logic_vector(numberOfBits-1 downto 0);
        ALU_OP : in std_logic_vector(3 downto 0);
        readData1_out : out std_logic_vector(numberOfBits-1 downto 0)
        );
end component;

component leftShifter is

generic(numberOfBits : integer := 32);

  Port (
        left_in : in std_logic_vector(numberOfBits-1 downto 0);
        left_out : out std_logic_vector(numberOfBits-1 downto 0)
        );
end component;

component ALU is
    generic
            (numberOfBits : integer := 32
            );
            
     Port (ALU_Control : in std_logic_vector(3 downto 0);
           A : in std_logic_vector(numberOfBits-1 downto 0);
           B : in std_logic_vector(numberOfBits-1 downto 0);
           ALU_Result : out std_logic_vector(numberOfBits-1 downto 0);
           ZERO: out std_logic
            );
end component;

component MUX_5Bit is
        generic(
                numberOfBits : integer := 32
                );
        
         Port (input1_MUX5 : in std_logic_vector (numberOfBits-1 downto 0);
               input2_MUX5 : in std_logic_vector (numberOfBits-1 downto 0);
               input3_MUX5 : in std_logic_vector (numberOfBits-1 downto 0);
               sel : in std_logic_vector(1 downto 0);
               out_MUX5 : out std_logic_vector (numberOfBits-1 downto 0)
              );     
end component;

component MUX is
 generic(
         numberOfBits : integer := 32
         );
  Port (
        A : in std_logic_vector(numberOfBits-1 downto 0);
        B : in std_logic_vector(numberOfBits-1 downto 0);
        sel : in std_logic;
        MUX_out : out std_logic_vector(numberOfBits-1 downto 0)
        );
end component;


component ProgramCounter is

    generic(numberOfBits : integer := 32
            );
    
      Port ( 
            address : in std_logic_vector(numberOfBits-1 downto 0);
            reset : in std_logic;
            clk : in std_logic;
            PCresult : out std_logic_vector (numberOfBits -1 downto 0)
            );
end component;

component NBitAdder is
generic(
        numberOfBits : integer := 32
        );
        
 Port  ( 
        first_numb : in std_logic_vector(numberOfBits-1 downto 0)  := (others => '0');
        second_numb : in std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
        SUM : out std_logic_vector (numberOfBits-1 downto 0)
        );
end component;


component instructionMemory is
        generic(
                numberOfBits : integer := 32 
                );
         Port ( clk : in std_logic;
                readAddress : in std_logic_vector(numberOfBits-1 downto 0);
                instruction : out std_logic_vector(numberOfBits-1 downto 0)   
                );
                
end component;



component RegisterFile is

        generic(numberofBits : integer := 32
                );
        
       Port (
                clk,reset : in std_logic;
                readRegister1 : in std_logic_vector (4 downto 0);
                readRegister2 : in std_logic_vector (4 downto 0);
                regWrite : in std_logic;
                writeRegister : in std_logic_vector (4 downto 0);
                writeData : in std_logic_vector(numberofBits-1 downto 0);
                readData1 : out std_logic_vector (numberofBits-1 downto 0);
                readData2 : out std_logic_vector (numberofBits-1 downto 0)
               );
               
end component;

component SignExtension is
generic(
        numberOfBits : integer := 32
        );

  Port (inp_sign : in std_logic_vector(numberOfBits/2 -1 downto 0);
        out_sign : out std_logic_vector(numberOfBits -1 downto 0)
        );
        
end component;



component DataMemoryUnit is
        generic(
                numberOfBits : integer := 32
                );
        
          Port (
                Address : in std_logic_vector(numberOfBits-1 downto 0);
                writeData : in std_logic_vector(numberOfBits-1 downto 0);
                regWrite : std_logic;
                regRead : std_logic;
                clk : in std_logic;
                reset : in std_logic;
                readData : out std_logic_vector(numberOfBits-1 downto 0)
                 );
end component;




signal PCresult : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal PCAddResult : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal upMUX : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal instruction : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal writeRegInp : std_logic_vector(4 downto 0) := (others => '0');
signal readData1 : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal readData2 : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal writeData : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal out_sign : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal ALUinp2 : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal readData1_out : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal ALU_Result : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal ZERO : std_logic := '0';


signal shigtExtended : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal left_out : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal SUM_left : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal readDataMem : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal readDataMem1 : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
signal readDataMem2 : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
----Controllers-----
signal PCSrc : std_logic;
signal RegDST : std_logic;
signal RegWrite : std_logic;
signal ALUSrc : std_logic_vector(1 downto 0);
signal ALUOp : std_logic_vector(3 downto 0);
signal MemRead : std_logic;
signal MemWrite : std_logic;
signal MemtoReg : std_logic;

begin



cont:  Controller 
 Port map(
        
       OpCode => instruction(numberOfBits-1 downto 26),
       Func => instruction(5 downto 0),
       ALUSrc => ALUSrc,
       RegDst => RegDst,
       RegWrite => RegWrite,
       ALUOp => ALUOp,
       MemRead => MemRead,
       MemWrite => MemWrite,
        MemtoReg => MemtoReg,
        PCSrc => PCSrc
       );

left_Shift_up: leftShifter 

generic map(numberOfBits => numberOfBits)

  Port map(
        left_in => out_sign,
        left_out =>left_out
        );
        
N_bit_add: NBitAdder 
generic map(
        numberOfBits => numberOfBits
        )
        
 Port map ( 
        first_numb => PCAddResult,
        second_numb => left_out,
        SUM =>SUM_left
        );

        
        



MUX_32_PC: MUX 
 generic map(
         numberOfBits => numberOfBits
         )
  Port map(
        A  => PCAddResult,
        B  => SUM_left,
        sel => PCSrc,
        MUX_out => upMUX
        );


PC_Counter :  ProgramCounter 

    generic map(numberOfBits => numberOfBits
            )
    
      Port map ( 
            address => upMUX,
            reset => reset,
            clk => clk,
            PCresult => PCresult
            );




pc_Add : PcAdder
    generic map(
            numberOfBits => numberOfBits
            )
    Port map (PCResult => PCresult,
          PCAddResult => PCAddResult
          );



inst_mem : instructionMemory 
        generic map(
                numberOfBits => numberOfBits
                )
         Port map ( 
                clk => clk,
                readAddress =>PCresult,
                instruction => instruction
                );
  
  
  
           
MUX_5BIT_1: MUX 
 generic map(
         numberOfBits => 5
         )
  Port map (
        A => instruction(20 downto 16),
        B => instruction(15 downto 11),
        sel => RegDST,
        MUX_out => writeRegInp
        );
        


                
registerFile1: RegisterFile 

        generic map(numberofBits => numberofBits
                )
        
       Port map(
                clk => clk,
                reset => reset,
                readRegister1 => instruction(25 downto 21),
                readRegister2 => instruction(20 downto 16),
                regWrite =>RegWrite,
                writeRegister => writeRegInp,
                writeData =>writeData,
                readData1 => readData1,
                readData2 =>readData2
               );     
  
 sign :  SignExtension 
generic map(
        numberOfBits => numberOfBits
        )

  Port map (inp_sign => instruction(numberOfBits/2 -1 downto 0),
        out_sign =>out_sign
        );
        
  
 signEX_MUX: signExtention_5Bit 
generic map(shiftBit => 5,
        numberOfBits => numberOfBits
        )

 Port map(shifAmnt => instruction(10 downto 6),
       shiftLarge => shigtExtended
        );

  
  
  MUX_5BIT_2: MUX_5Bit 

generic map(
        numberOfBits => numberOfBits
        )

 Port map(input1_MUX5 => readData2,
       input2_MUX5 =>out_sign,
       input3_MUX5 =>shigtExtended,
       sel => ALUSrc,
       out_MUX5 => ALUinp2
      );
      

  Shift_op_mux: ShiftOPMux 
generic map(
        numberOfBits => numberOfBits
        )
        
 Port map (
        readData1 => readData1,
        readData2 => readData2,
        ALU_OP => ALUOp,
        readData1_out => readData1_out
        );

                   
                      
ALU_main :  ALU 
    generic map
            (numberOfBits => numberOfBits
            )
            
     Port map (
           ALU_Control => ALUOp,
           A => readData1_out,
           B => ALUinp2,
           ALU_Result => ALU_Result,
           ZERO => ZERO
            );

DataMem : DataMemoryUnit 
        generic map(
                numberOfBits => numberOfBits
                )
        
          Port map (
                Address => ALU_Result,
                writeData => readData2,
                regWrite =>MemWrite,
                regRead => MemRead,
                clk => clk,
                reset => reset,
                readData =>readDataMem
                 );

 MUX_32_Data: MUX 
 generic map(
         numberOfBits => numberOfBits
         )
  Port map(
        A  => ALU_Result,
        B  => readDataMem,
        sel => MemtoReg,
        MUX_out => writeData
        );     

output <= writeData;

end Behavioral;
