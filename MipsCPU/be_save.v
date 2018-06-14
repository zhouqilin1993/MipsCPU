module be_save(sw,sb,sh,addr,bes);
  input             sw,sb,sh;
  input    [1:0]    addr;
  output   [3:0]    bes;
  
  assign  bes=
     (sw)? 4'b1111:
     (sh&&(addr[1]==1'b0))?   4'b0011:
     (sh&&(addr[1]==1'b1))?   4'b1100:
     (sb&&(addr==2'b00))  ?   4'b0001:
     (sb&&(addr==2'b01))  ?   4'b0010:
     (sb&&(addr==2'b10))  ?   4'b0100:
     (sb&&(addr==2'b11))  ?   4'b1000:
                                       4'bxxxx;
                                       
 endmodule
        
