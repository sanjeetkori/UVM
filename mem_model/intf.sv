interface intf(input logic clk,rst);
  logic [1:0] addr;
  logic       wr_en;
  logic       rd_en;
  logic [7:0] wdata;
  logic [7:0] rdata;

  clocking drv_cb @(posedge clk);
    default input #1 output #1;
    output addr;
    output wr_en;
    output rd_en;
    output wdata;
    input  rdata;
  endclocking

  clocking mon_cb @(posedge clk);
    default input #1 output #1;
    input addr;
    input wr_en;
    input rd_en;
    input wdata;
    input rdata;
  endclocking

  clocking design_cb @(posedge clk);
    default input #1 output #1;
    input addr;
    input wr_en;
    input rd_en;
    input wdata;
    output rdata;
  endclocking

  modport drv_mp (clocking drv_cb,input clk,rst);
  modport mon_mp (clocking mon_cb,input clk,rst);

  modport design_mp(clocking design_cb,input clk,rst);
endinterface