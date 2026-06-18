//==============================================================================
// MIPS Processor Testbench (Class 12 - Sync with Class 11)
//==============================================================================
// Description:
// Top-level testbench for verifying the MIPS processor with MMIO.
// Monitors:
// - Program Counter (PC)
// - ALU Results
// - Memory-Mapped PWM output
//==============================================================================
`timescale 1ns / 1ps

module mips_tb;
    reg         clk;
    reg         rst_n;
    reg [7:0] switches;
    
    // IO Ports

    wire        pwm_out;
    
    // Debug Monitoring
    wire [31:0] pc_out;
    wire [31:0] alu_result;
    
    // Unit Under Test (UUT)
    mips uut (
        .clk(clk),
        .rst_n(rst_n),
        .switches(switches),
        .pwm_out(pwm_out),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );
    
    // Clock Generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Trace Generation
    initial begin
        $dumpfile("mips.vcd");
        $dumpvars(0, mips_tb);
    end
    
    // Simulation Control
    initial begin
        // Reset Logic
        rst_n = 0;
        switches = 8'h40;
        #15;
        rst_n = 1;
        
        $display("===========================================");
        $display("   MIPS Class 12: Synced Simulation        ");
        $display("===========================================");
        
        // Stimulus Example: Set switches
        // #100;
        //switches = 8'hAA; // Binary 10101010
        /*#50000 switches = 8'h80;
        #50000 switches = 8'hC0;
        #50000 switches = 8'hFF;
    */
        #10 switches = 8'h40;
        #10 switches = 8'h80;
        #10 switches = 8'hC0;
        #10 switches = 8'hFF;
        // Wait for 300us to observe Accel/Decel sequence
        #300000;
        
        $display("===========================================");
        $display("   Simulation Complete                   ");
        $display("===========================================");
        $finish;
    end
    
    // Monitor Outputs


endmodule