module be_load(lw,lh,lhu,lb,lbu,addr,bel);
  input             lw,lh,lhu,lb,lbu;
  input    [1:0]    addr;
  output   [6:0]    bel;
  
  assign  bel=
    (lw)                ?    7'b0001111:
    (lh&&addr[1]==1'b0) ?    7'b0010011:
    (lh&&addr[1]==1'b1) ?    7'b0011100:
    (lhu&&addr[1]==1'b0)?    7'b0100011:
    (lhu&&addr[1]==1'b1)?    7'b0101100:
    (lb&&addr==2'b00)   ?    7'b0110001:
    (lb&&addr==2'b01)   ?    7'b0110010:
    (lb&&addr==2'b10)   ?    7'b0110100:
    (lb&&addr==2'b11)   ?    7'b0111000:
    (lbu&&addr==2'b00)  ?    7'b1000001:
    (lbu&&addr==2'b01)  ?    7'b1000010:
    (lbu&&addr==2'b10)  ?    7'b1000100:
    (lbu&&addr==2'b11)  ?    7'b1001000:
                                         7'bxxxxxxx;
endmodule

