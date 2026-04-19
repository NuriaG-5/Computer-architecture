timescale 1ns / 1ps
module main_decoder (
    input  wire [5:0] opcode,       // instruction opcode
    
    output wire       mem_to_reg,   // write-back select: 1=memory, 0=ALU
    output wire       mem_write,    // memory write enable (for sw)
    output wire       branch,       // branch enable signal (for beq)
    output wire       alu_src,      // ALU source select: 1=immediate, 0=register
    output wire       reg_dst,      // register destination select: 1=rd, 0=rt
    output wire       reg_write,    // register file write enable
    output wire [1:0] alu_op        // ALU operation type for ALU decoder
);

    reg [5:0] control_main;
    reg [1:0] alu_op_reg;

    assign {reg_write, reg_dst, alu_src, branch, mem_write, mem_to_reg} = control_main;
    assign alu_op = alu_op_reg;
    //reg [7:0] controls;             // internal control signal vector (8 bits)
    // assign control bits from the vector
    //assign {reg_write, reg_dst, alu_src, branch, mem_write, mem_to_reg, alu_op} = controls;
    
    always @(*) begin              // combinatorial decoding logic
        case (opcode)              // decode based on opcode
            
            6'b000000: begin // R-type
            control_main = 6'b1_1_0_0_0_0;
            alu_op_reg   = 2'b10;
        end

        6'b100011: begin // lw
            control_main = 6'b1_0_1_0_0_1;
            alu_op_reg   = 2'b00;
        end

        6'b101011: begin // sw
            control_main = 6'b0_0_1_0_1_0;
            alu_op_reg   = 2'b00;
        end

        6'b000100: begin // beq
            control_main = 6'b0_0_0_1_0_0;
            alu_op_reg   = 2'b01;
        end

        6'b001000: begin // addi
            control_main = 6'b1_0_1_0_0_0;
            alu_op_reg   = 2'b00;
        end

        6'b001101: begin // ori
            control_main = 6'b1_0_1_0_0_0;
            alu_op_reg   = 2'b11; // 🔥 clave
        end

        default: begin
            control_main = 6'b0_0_0_0_0_0;
            alu_op_reg   = 2'b00;
        end
          
        endcase
    end
endmodule
