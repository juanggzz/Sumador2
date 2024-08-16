/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_Sumador1b (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire S1,cl,S2;

XORx XOR1(.OUT(S1),.A(ui_in[0]),.B(ui_in[1]));
ANDx AND2(.OUT(cl),.A(ui_in[0]),.B(ui_in[1]));

XORx XOR3(.OUT(uo_out[0]),.A(S1),.B(ui_in[2]));
ANDx AND4(.OUT(S2),.A(S1),.B(ui_in[2]));

XORx XOR5(.OUT(uo_out[1]),.A(S2),.B(cl));
    
  // All output pins must be assigned. If not used, assign to 0.
    assign uo_out[7:2]  = 6'b0;  // Example: ou_out is the sum of ui_in and uio_in
    assign uio_out[7:0] = 8'b0;
    assign uio_oe[7:0]  = 8'b0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n,ui_in[7:3],ui_out[7:3], 1'b0};

endmodule
