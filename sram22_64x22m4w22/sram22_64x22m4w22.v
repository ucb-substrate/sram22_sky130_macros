// SRAM22 SRAM model
// Words: 64
// Word size: 22
// Write size: 22

module sram22_64x22m4w22(
`ifdef USE_POWER_PINS
  vdd,
  vss,
`endif
  clk,rstb,ce,we,wmask,addr,din,dout
);

  localparam DATA_WIDTH = 22;
  localparam ADDR_WIDTH = 6;
  localparam WMASK_WIDTH = 1;
  localparam RAM_DEPTH = 1 << ADDR_WIDTH;

`ifdef USE_POWER_PINS
  inout vdd; // power
  inout vss; // ground
`endif
  input  clk; // clock
  input  rstb; // reset bar (active low reset)
  input  ce; // chip enable
  input  we; // write enable
  input wmask; // whole-word write enable
  
  input [ADDR_WIDTH-1:0]  addr; // address
  input [DATA_WIDTH-1:0]  din; // data in
  output reg [DATA_WIDTH-1:0] dout; // data out

  reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

  always @(posedge clk)
  begin
    if (ce && rstb) begin
      // Write
      if (we) begin
          if (wmask) begin
            mem[addr][21:0] <= din[21:0];
          end
      end

      // Read
      if (!we) begin
        dout <= mem[addr];
      end
    end
  end

endmodule
