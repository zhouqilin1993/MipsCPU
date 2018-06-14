module pc(clk,rst,npc,pc_out,PCWr);
  input              rst,clk;
  input   [31:0]     npc;
  input              PCWr;
  output  [31:0]     pc_out;
  
  reg     [31:0]     npc_reg;
  
  always @(posedge clk)
  begin
     if(rst)  
        npc_reg <=32'h0000_3000;
     else if(PCWr)
        npc_reg = npc;
  end

  assign  pc_out = npc_reg;
endmodule