module im(clk,addr,opcode,IRWr);
  input                   clk;
  input    [31:0]         addr;
  input                   IRWr;
  output   [31:0]         opcode;
  
  reg      [31:0]    im_out;
  reg      [31:0]    im   [1023:0];
    
  initial
     begin
        $readmemh("code.txt",im);
     end
     
  always@(posedge clk) 
    if(IRWr)
       im_out = im[addr[11:2]];
   
  assign  opcode = im_out;   
   
endmodule 