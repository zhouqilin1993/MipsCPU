module npc (pc,branch,zero,j,jr,jal,pcplus4,npc,pc_jr,imm,bne,blez,bgtz,bltz,bgez,rd1);
    input      [31:0]      pc,pc_jr,rd1;
    input      [25:0]      imm;
    input                  branch,zero,j,jr,jal,bne,blez,bgtz,bltz,bgez;
    output     [31:0]      pcplus4,npc;
    
    assign  npc=
      (blez&&(rd1[31]||rd1==0))     ?  pc+{14'b0,imm[15:0],2'b0}:
      (bgtz&&(rd1[31]==0&&rd1!=0))  ?  pc+{14'b0,imm[15:0],2'b0}:
      (bltz&&rd1[31])               ?  pc+{14'b0,imm[15:0],2'b0}:
      (bgez&&(rd1[31]==0||rd1==0))  ?  pc+{14'b0,imm[15:0],2'b0}:
      (branch&&zero||bne&&zero==0)  ?  pc+{14'b0,imm[15:0],2'b0}:
      (j|jal)                       ?  {pc[31:28],imm[25:0],2'b0}:
      (jr)                          ?  pc_jr:
                                             pc+4;
    assign  pcplus4=pc;
endmodule 
