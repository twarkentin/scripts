// ----------------------------------------------------------------------------
// FILE NAME      : trs.v
// CURRENT AUTHOR : Tim Warkentin
// AUTHOR'S EMAIL : tim.warkentin@gmail.com
// ----------------------------------------------------------------------------
// PURPOSE        : This module does a truncation followed by a round followed 
//                  by a saturation check. 
// ----------------------------------------------------------------------------

timeunit      1ns;
timeprecision 1ps;

module trs #( 

  parameter  IN_WIDTH  = 36, 
  parameter  OUT_WIDTH = 16,
  parameter  TRUNC     = 18 )

  (
    input  signed [ IN_WIDTH-1:0] din,
    output signed [OUT_WIDTH-1:0] dout,
    output                        sat
  );
  
  localparam TRUNC_WIDTH = IN_WIDTH - TRUNC;

  wire [TRUNC_WIDTH-1:0] din_trunc;
  wire   [TRUNC_WIDTH:0] din_trunc_rnd;

  assign din_trunc     = din[IN_WIDTH-1:TRUNC];
  assign din_trunc_rnd = din_trunc + din[TRUNC-1];

  sat #(.IN_WIDTH(TRUNC_WIDTH+1), .OUT_WIDTH(OUT_WIDTH) ) sat_detect (
    .din  ( din_trunc_rnd ),
    .dout ( dout ),
    .sat  ( sat )
  );

endmodule

