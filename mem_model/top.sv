`include "Files.sv"

module top;
  bit clk,rst;
  intf pif(clk,rst);
  mem DUT(pif);

  always #5 clk = ~clk;

  initial begin
    rst = 1;
    #5 rst = 0;
  end

  initial begin
    uvm_config_db#(virtual intf)::set(null,"","pif",pif);
    run_test("mem_test");
  end
endmodule