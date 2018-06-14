module mips(clk,reset);
  input            clk,reset;
  
  wire    [31:0]   rd1,rd2,sign_ext,zero_ext,GPRw_data,opcode,pcout,Aluresult,DMreg_data,alub,sign,npc,pcp4;
  wire    [6:0]    bel;
  wire    [4:0]    GPRw_addr;
  wire    [3:0]    bes;
  wire    [2:0]    Aluctrl;
  wire    [1:0]    WDSel,GPRSel,BSel;
  wire             GPRWr,Branch,DMWr,Jump,Jal,Jr,zero,PCWr,IRWr,sb,sh,sw,lb,lh;
  wire             lbu,lhu,lw,bne,blez,bgtz,bltz,bgez,sll,srl,sra,sllv,srlv,srav;
  
  controller U_CTR(clk,reset,opcode[31:26],opcode[5:0],GPRWr,GPRSel,BSel,Branch,
                   DMWr,WDSel,Jump,Jal,Jr,Aluctrl,PCWr,IRWr,sb,sh,sw,lb,lh,lbu,lhu,lw,bne,
                   blez,bgtz,bltz,bgez,opcode[20:16],zero,rd1,sll,srl,sra,sllv,srlv,srav);
  alu        U_ALU(rd1,alub,Aluctrl,zero,sign,Aluresult,clk,sll,srl,sra,sllv,srlv,srav,opcode[10:6]);
  dm         U_DM(clk,DMWr,Aluresult,rd2,bes,bel,DMreg_data);
  sign_ext   U_SEXT(opcode[15:0],sign_ext);
  zero_ext   U_ZEXT(opcode[15:0],zero_ext);
  im         U_IM(clk,pcout,opcode,IRWr); 
  npc        U_NPC(pcout,Branch,zero,Jump,Jr,Jal,pcp4,npc,Aluresult,opcode[25:0],bne,blez,bgtz,bltz,bgez,rd1);
  pc         U_PC(clk,reset,npc,pcout,PCWr);
  gpr        U_GPR(clk,GPRWr,opcode[25:21],opcode[20:16],GPRw_addr,GPRw_data,rd1,rd2);
  be_save    U_BES(sw,sb,sh,Aluresult[1:0],bes);
  be_load    U_BEL(lw,lh,lhu,lb,lbu,Aluresult[1:0],bel);
  mux32      U_BSel(rd2,zero_ext,sign_ext,0,BSel,alub);   
  mux32      U_WDSel(Aluresult,DMreg_data,pcp4,sign,WDSel,GPRw_data);
  mux5       U_GPRSel(opcode[20:16],opcode[15:11],5'b11111,GPRSel,GPRw_addr);
  
 endmodule








