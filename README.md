# AES-128-with-an-Instruction-Set
This is a Verilog implementation of the symmetric block cipher AES (Advanced Encryption Standard).  
This implementation only supports 128 bit keys.  
This project is developed basic on https://github.com/secworks/aes  
This project delete the AES-256 part of secworks' project.  

## Function
### mode select
There are two pins used to select the mode. cu and id/ed.  
You could not change cu unless reset is available.
#### cu
cu means config_usual.  
The system will work in config mode when cu=1, and work in usual mode when cu=0.  
Config mode means you could config the system by input some instruction.   
Usual mode means you could only select encipher mode or decipher mode when you use this system.   
The others configuration options will use a default value built in the system.  
#### id (when config mode)
id means instruction_data.  
The system will work in instruction mode when id=1, and work in data mode when id=0.  
When you finish the config process, you could let id<=0 to switch to data mode.  
In instruction mode, your input will be processed as an instruction and used to config the system.  
In data mode, your data will be input into the AES module. You will get the result after some clocks.  
#### ed (when usual mode)
id means encipher_decipher.  
The system will work in encipher mode when ed=1, and work in decipher mode when ed=0.  
When you select usual mode, the only one thing you could do is select encipher of decipher mode and input your data.  
The usual mode is dsigned to work with some simple modules.   

### instruction set
There is an instruction set(aes_iset.v) in this project. The instruction set will process the data user inputs, and control the system to work. There are three instructions in the instruction set now.   
All instructions are 32bit. 24bit operation code + 8bit operation data.  
In this project, the operation code data are ASCII code.  
MOD: used to config encipher or decipher mode.   
  MODE: encipher mode.  
  MODD: decipher mode.  
KEY: config a key.  
  KEYF: Full 128bit key.  
  KEYQ: 32bit key. The higher 96bit key will be configed to default key built in the system.  
  KEYN: default key.  
SPD: config the speed of outport.  
  The operation data is a 4bit number between 0x01 to 0x0f. The outport will output one byte data per 2^n clock periods.(n is the operation data)

### interfaces
#### in_port & shi
The in_port will convert 8bit data to 32bit data and output to the instruction set module.  
The shi is a shakehand signal. You should turn it to (~shi) when you input a new 8bit data.  
You should hold a data more than 5 clock period.  
#### out_port
The out_port will convert 4*32bit result data to 16*8bit output data.  
The default speed of it is 16 clock periods per 8bit data.  
#### Tips
The speed of in_port should faster than the out_port's to ensure the system could work continuously.
