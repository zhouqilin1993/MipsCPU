module  dm (clk,we,addr,wd,bes,bel,rdata);
    input                  clk,we;
    input       [31:0]     addr,wd;
    input       [3:0]      bes;
    input       [6:0]      bel;
    output      [31:0]     rdata; 
      
    reg         [31:0]     DM   [1023:0];
    reg         [31:0]     dout_reg;

	   always@(posedge clk)
	   if(we)
        case(bes)
        4'b1111: DM[addr[11:2]] <= wd;
        4'b0011: DM[addr[11:2]][15:0] <= wd[15:0];
        4'b1100: DM[addr[11:2]][31:16] <= wd[15:0];
        4'b0001: DM[addr[11:2]][7:0] <= wd[7:0];
        4'b0010: DM[addr[11:2]][15:8] <= wd[7:0];
        4'b0100: DM[addr[11:2]][23:16] <= wd[7:0];
        4'b1000: DM[addr[11:2]][31:24] <= wd[7:0];
      endcase
      
 	   always@(posedge clk)
 	      case(bel[6:4])
 	      3'b000: dout_reg<=DM[addr[11:2]];        //lw
 	      3'b001: case(bel[3:0])                  //lh 	              
 	                4'b0011:dout_reg<={{16{DM[addr[11:2]][15]}},DM[addr[11:2]][15:0]};
 	                4'b1100:dout_reg<={{16{DM[addr[11:2]][31]}},DM[addr[11:2]][31:16]}; 
 	              endcase
 	      3'b010: case(bel[3:0])                  //lhu 	              
 	                4'b0011:dout_reg<={16'b0,DM[addr[11:2]][15:0]};
 	                4'b1100:dout_reg<={16'b0,DM[addr[11:2]][31:16]};
 	              endcase
 	      3'b011: case(bel[3:0])                  //lb 	              
 	                4'b0001:dout_reg<={{24{DM[addr[11:2]][7]}},DM[addr[11:2]][7:0]};
 	                4'b0010:dout_reg<={{24{DM[addr[11:2]][15]}},DM[addr[11:2]][15:8]};
 	                4'b0100:dout_reg<={{24{DM[addr[11:2]][23]}},DM[addr[11:2]][23:16]};
 	                4'b1000:dout_reg<={{24{DM[addr[11:2]][31]}},DM[addr[11:2]][31:24]};
 	              endcase
 	      3'b100: case(bel[3:0])                  //lbu 	             
 	                4'b0001:dout_reg<={24'b0,DM[addr[11:2]][7:0]};
 	                4'b0010:dout_reg<={24'b0,DM[addr[11:2]][15:8]};
 	                4'b0100:dout_reg<={24'b0,DM[addr[11:2]][23:16]};
 	                4'b1000:dout_reg<={24'b0,DM[addr[11:2]][31:24]};
 	              endcase
        endcase
        
     assign   rdata = dout_reg;
     
   endmodule
