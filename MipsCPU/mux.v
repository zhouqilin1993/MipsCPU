
module mux32 (a,b,c,d,select,y);
  input    [1:0]    select;
  input    [31:0]   a,b,c,d;
  output   [31:0]   y;
  
  assign  y=
    (select==2'b00)  ? a :
    (select==2'b01)  ? b :
    (select==2'b10)  ? c :
                           d;
                          
endmodule

  
module mux5 (a,b,c,select,y);
  input     [1:0]    select;
  input     [4:0]    a,b,c;
  output    [4:0]    y;
  assign  y=
    (select==2'b00)  ? a :
    (select==2'b01)  ? b :
                           c;
                           
endmodule
  












  
  
  
  
  
  
  
  
  
  
  
  
  