module mem (intf pif);

   logic [7:0] mem [4];

   always @(posedge pif.rst) begin
	   foreach(mem[i]) mem[i] <= 8'hFF;
   end
   //always @(posedge pif.rst) begin
   //   for(int i = 0; i < 4 ; i++)
   //     mem[i] <= 8'hFF;
   //end

   always @(posedge pif.clk) begin
      if(pif.wr_en) mem[pif.addr] <= pif.wdata;
      if(pif.rd_en) pif.rdata     <= mem[pif.addr];
   end

endmodule
