module adder (intf pif);
  always @(posedge pif.clk) 
    if(!pif.rst)
      pif.sum = pif.a + pif.b + pif.c;
    else
      pif.sum = 0;
endmodule