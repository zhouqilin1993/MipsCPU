`include ".//head_mips.v"
module controller(clk,reset,op,func,GPRWr,GPRSel,BSel,Branch,DMWr,WDSel,
                  Jump,Jal,Jr,Aluctrl,PCWr,IRWr,sb,sh,sw,lb,lh,lbu,lhu,lw,bne,blez,bgtz,
                  bltz,bgez,f,zero,rd,sll,srl,sra,sllv,srlv,srav);
  input                 clk,reset,zero;
  input     [5:0]       op,func;
  input     [4:0]       f;
  input     [31:0]      rd;
  output                GPRWr,Branch,DMWr,Jump,Jal,Jr,PCWr,IRWr,sb,sh,sw,lb,lh,lbu;
  output                lhu,lw,bne,blez,bgtz,bltz,bgez,sll,srl,sra,sllv,srlv,srav;
  output    [1:0]       GPRSel,WDSel,BSel;
  output    [2:0]       Aluctrl; 
  
  reg  [5:0]       fsm;
  
  always@(posedge clk)
    if(reset)   fsm<=`s0;      
    else 
   case (fsm)
    `s0:   fsm<=`s1;
    `s1: if(op==`R_OP&&(func==`SUBU_FUNC||func==`SLT_FUNC||func==`SUB_FUNC)) fsm<=`s3;
         else if(op==`R_OP&&(func==`ADDU_FUNC||func==`JR_FUNC||func==`ADD_FUNC)) fsm<=`s2;
         else if(op==`ORI_OP) fsm<=`s13;
         else if(op==`LUI_OP) fsm<=`s14;
         else if(op==`ADDI_OP||op==`ADDIU_OP||op==`LB_OP||op==`LBU_OP||op==`LH_OP||op==`LHU_OP
                 ||op==`LW_OP||op==`SB_OP||op==`SH_OP||op==`SW_OP) fsm<=`s8;
         else if(op==`SLTI_OP||op==`SLTIU_OP) fsm<=`s15;
         else if(op==`BEQ_OP) fsm<=`s16;
         else if(op==`J_OP)   fsm<=`s17;
         else if(op==`JAL_OP) fsm<=`s18;
         else if(op==`BNE_OP) fsm<=`s21;
         else if(op==`BLEZ_OP||op==`BGTZ_OP||op==`BLTZ_OP||op==`BGEZ_OP) fsm<=`s22;           
         else if(op==`R_OP&&(func==`AND_FUNC||func==`OR_FUNC||func==`XOR_FUNC||func==`NOR_FUNC))  fsm<=`s20;
         else if(op==`ANDI_OP||op==`XORI_OP)    fsm<=`s23;
         else if(op==`R_OP&&func==`JALR_FUNC)   fsm<=`s24; 
         else if(op==`R_OP&&(func==`SLL_FUNC||func==`SRL_FUNC||func==`SRA_FUNC||func==`SLLV_FUNC
                 ||func==`SRLV_FUNC||func==`SRAV_FUNC))   fsm<=`s25;
                         
             
    `s2: if(op==`R_OP&&(func==`ADDU_FUNC||func==`ADD_FUNC))   fsm<=`s4;
         else if(func==`JR_FUNC)  fsm<=`s5;
    `s3: if(op==`R_OP&&(func==`SUBU_FUNC||func==`SUB_FUNC))   fsm<=`s6;
         else if(func==`SLT_FUNC)fsm<=`s7;
    `s4: fsm<=`s0;
    `s5: fsm<=`s0;
    `s6: fsm<=`s0;
    `s7: fsm<=`s0;
    `s8: if( op ==`ADDI_OP || op ==`ADDIU_OP)  fsm<=`s9;
         else if(op==`LB_OP||op==`LBU_OP||op==`LH_OP||op==`LHU_OP||op==`LW_OP) fsm<=`s10;
         else if(op==`SH_OP||op==`SB_OP||op==`SW_OP)  fsm<=`s11;     
    `s9: fsm<=`s0;
    `s10: fsm<=`s12;
    `s11: fsm<=`s0;
    `s12: fsm<=`s0;
    `s13: fsm<=`s9;
    `s14: fsm<=`s9;
    `s15: fsm<=`s0;
    `s16: fsm<=`s0;
    `s17: fsm<=`s0;
    `s18: fsm<=`s19;
    `s19: fsm<=`s0;
    `s21: fsm<=`s0;
    `s22: fsm<=`s0;
    `s20: fsm<=`s4;
    `s23: fsm<=`s9;
    `s24: fsm<=`s5;
    `s25: fsm<=`s4;          
   endcase 
   
   assign GPRWr= (fsm==`s4||fsm==`s6||fsm==`s7||fsm==`s9||fsm==`s12||fsm==`s15||fsm==`s18||fsm==`s24);
   assign GPRSel= (fsm==`s4||fsm==`s6||fsm==`s7) ?  2'b01:
                  (fsm==`s18||fsm==`s24)         ?  2'b10:
                                                           2'b00;
   assign BSel= (fsm==`s13||fsm==`s23)           ?  2'b01:
                  (fsm==`s8||fsm==`s14||fsm==`s15) ?  2'b10:
                                                             2'b00;
   assign Branch=(fsm==`s16);
   assign DMWr=(fsm==`s11);
   assign WDSel=(fsm==`s12)            ?   2'b01:
                   (fsm==`s18||fsm==`s24) ?   2'b10:
                   (fsm==`s7||fsm==`s15)  ?   2'b11:
                                                     2'b00;
   assign Jump=(fsm==`s17);
   assign Jal=(fsm==`s19);
   assign Jr=(fsm==`s5);
   assign PCWr=(fsm==`s1||fsm==`s5||fsm==`s16&&zero||fsm==`s17||fsm==`s19||fsm==`s21&&zero==0
               ||fsm==`s22&&(   blez&&(rd[31]||rd==0)  ||  bgtz&&(rd[31]==0&&rd!=0)  ||  
                bltz&&rd[31]  ||  bgez&&(rd[31]==0||rd==0)  ));
   assign IRWr=(fsm==`s0);
   assign Aluctrl=(fsm==`s3||fsm==`s7||fsm==`s16||fsm==`s15||fsm==`s21) ? 3'b001:
                  (fsm==`s13||fsm==`s20&&func==`OR_FUNC)                ? 3'b010:
                  (fsm==`s14)                                           ? 3'b011:
                  (fsm==`s20&&func==`AND_FUNC||fsm==`s23&&op==`ANDI_OP) ? 3'b100:
                  (fsm==`s20&&func==`XOR_FUNC||fsm==`s23&&op==`XORI_OP) ? 3'b101:
                  (fsm==`s20&&func==`NOR_FUNC)                          ? 3'b110:
                  (fsm==`s25)                                           ? 3'b111:
                                                                                  3'b000;
   assign sb=(fsm==`s11&&op==`SB_OP);  
   assign sh=(fsm==`s11&&op==`SH_OP);
   assign sw=(fsm==`s11&&op==`SW_OP);
   assign lb=((fsm==`s12||fsm==`s10)&&op==`LB_OP);
   assign lh=((fsm==`s12||fsm==`s10)&&op==`LH_OP);
   assign lbu=((fsm==`s12||fsm==`s10)&&op==`LBU_OP);
   assign lhu=((fsm==`s12||fsm==`s10)&&op==`LHU_OP);
   assign lw=((fsm==`s12||fsm==`s10)&&op==`LW_OP);      
      
   assign bne=(fsm==`s21);
   assign blez=(fsm==`s22&&op==`BLEZ_OP);
   assign bgtz=(fsm==`s22&&op==`BGTZ_OP);
   assign bltz=(fsm==`s22&&op==`BLTZ_OP&&f==`BLTZ_F);
   assign bgez=(fsm==`s22&&op==`BGEZ_OP&&f==`BGEZ_F);
      
   assign sll=(fsm==`s25&&func==`SLL_FUNC);
   assign srl=(fsm==`s25&&func==`SRL_FUNC);
   assign sra=(fsm==`s25&&func==`SRA_FUNC);
   assign sllv=(fsm==`s25&&func==`SLLV_FUNC);
   assign srlv=(fsm==`s25&&func==`SRLV_FUNC);
   assign srav=(fsm==`s25&&func==`SRAV_FUNC);
   
endmodule
      



          
          
   
  

  
