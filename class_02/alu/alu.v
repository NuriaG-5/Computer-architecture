`timescale 1ns/1ps
module alu (
    input  wire [31:0] src_a,      // operand A
    input  wire [31:0] src_b,      // operand B
    input  wire [3:0]  alu_ctrl,   // operation select
    output reg  [31:0] result,     // result
    output wire        zero        // zero flag
);
    always @(*) begin
        case (alu_ctrl)
            4'b0000: result = src_a & src_b;                        // AND
            4'b0001: result = src_a | src_b;                        // OR
            4'b0010: result = src_a + src_b;                        // ADD
            4'b0110: result = src_a - src_b;                        // SUB
            4'b0111: result = ($signed(src_a) < $signed(src_b)) ? 1 : 0; // SLT
            4'b1000: result = src_a ^ src_b;  // XOR
            4'b1001: result = ~(src_a | src_b); // NoR
            4'b1010: result = src_a << src_b[4:0]; // SLL
            default: result = 32'd0;
        endcase
    end
    assign zero = (result == 32'd0);
endmodule