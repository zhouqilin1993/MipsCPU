
module testbench_mips() ;
	reg		clk ;
	reg		rst ;
	
	mips	MIPS(clk, rst) ;
	
	initial	
     begin
		   clk = 0 ;
		   rst = 1 ;
		   #100	rst = 0 ;
	   end
	
	always
		#20 clk = ~clk ;
	
endmodule