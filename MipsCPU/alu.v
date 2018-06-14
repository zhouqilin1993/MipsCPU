module alu (a,b,aluctrl,zero,sign,result,clk,sll,srl,sra,sllv,srlv,srav,s);
  input      [31:0]     a,b;
  input      [4:0]      s;
  input      [2:0]      aluctrl;
  input                 clk,sll,srl,sra,sllv,srlv,srav;
  output     [31:0]     result,sign;
  output                zero;
  
  wire       [31:0]     wire_alu;
  reg        [31:0]     resultreg;
  reg        [31:0]     c;
  reg                   d;
  integer               i;
  
  always @(*) 
   begin
     if(sra)
       begin
           d=b[31];
           c=b;
         for(i=0;i<s;i=i+1)
           c={d,c[31:1]};
       end
     else if(srav)
       begin
           d=b[31];
           c=b;
         for(i=0;i<a;i=i+1)
           c={d,c[31:1]};
       end       
   end
   
  assign wire_alu =
    (aluctrl==3'b000)        ?  a+b :
    (aluctrl==3'b001)        ?  a-b :
    (aluctrl==3'b010)        ?  a|b :
    (aluctrl==3'b011)        ?  {b[15:0],16'b0} :
    (aluctrl==3'b100)        ?  a&b :
    (aluctrl==3'b101)        ?  a&~b|~a&b :
    (aluctrl==3'b110)        ?  ~(a|b) :
    (aluctrl==3'b111&&sll)   ?  b<<s :
    (aluctrl==3'b111&&srl)   ?  b>>s :
    (aluctrl==3'b111&&sra)   ?  c :
    (aluctrl==3'b111&&sllv)  ?  b<<a :
    (aluctrl==3'b111&&srlv)  ?  b>>a :
    (aluctrl==3'b111&&srav)  ?  c :    
                                     32'b0;
    
  always@(posedge clk)
    resultreg<=wire_alu;    
    
  assign zero=(wire_alu==0);
  assign sign={31'b0,wire_alu[31]};
  assign result=resultreg;
  
endmodule