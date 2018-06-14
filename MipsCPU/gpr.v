module gpr(clk,we,ra1,ra2,wa,wd,rd1,rd2);
  input                      clk,we;
  input        [4:0]         ra1,ra2,wa;
  input        [31:0]        wd;
  output       [31:0]        rd1,rd2;
  
  reg       [31:0]     rd1_reg;
  reg       [31:0]     rd2_reg;
  reg       [31:0]     rf  [31:0];
  
  integer			i ;
	initial	
	  begin
		   for (i = 0; i < 32; i = i + 1)
			    rf[i] <= 32'b0;
	  end
	
	always @(posedge clk)
    if(we) 
      rf[wa] <= wd;
        
	always@(posedge clk )
	  begin
	    rd1_reg <= rf[ra1];
	    rd2_reg <= rf[ra2];
	  end
	  
	assign rd1 = rd1_reg;	
  assign rd2 = rd2_reg;

endmodule