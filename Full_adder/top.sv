`include "Files.sv"

module top;
  bit clk,rst;
  intf pif(clk,rst);
  adder dut(pif);

  initial begin
    uvm_config_db#(virtual intf)::set(null,"","pif",pif);
    run_test("adder_test");
  end

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #2 rst = 0;
  end
endmodule