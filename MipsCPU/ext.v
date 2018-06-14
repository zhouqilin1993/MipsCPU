module sign_ext(a,b);
      input [15:0]  a;
      output [31:0] b;
      assign b={{16{a[15]}},a};
endmodule


module zero_ext(a,b);
  input [15:0] a;
  output [31:0] b;
  assign b={16'b0,a};
endmodule