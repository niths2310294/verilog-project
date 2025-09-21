`timescale 1ns/1ps
module tb_vending_machine;

    reg clk, reset;
    reg coin_5, coin_10;
    reg select_1, select_2;
    wire dispense_1, dispense_2;
    wire change_5, change_10;

    vending_machine vm(
        .clk(clk),
        .reset(reset),
        .coin_5(coin_5),
        .coin_10(coin_10),
        .select_1(select_1),
        .select_2(select_2),
        .dispense_1(dispense_1),
        .dispense_2(dispense_2),
        .change_5(change_5),
        .change_10(change_10)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Waveform generation for simulation
    initial begin
        $dumpfile("waves.vcd");             // Output waveform file
        $dumpvars(0, tb_vending_machine);   // Dump all signals in this testbench
    end

    // Test stimulus
    initial begin
        reset = 1; coin_5 = 0; coin_10 = 0; select_1 = 0; select_2 = 0;
        #20 reset = 0;

        //Product 1 (exact price 15)
        #10 coin_5 = 1; #10 coin_5 = 0;
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 select_1 = 1; #10 select_1 = 0;

        Product 1 with extra coin → change 5 
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 select_1 = 1; #10 select_1 = 0;

       Product 2 (cost 25) with extra coin → change 5 
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 select_2 = 1; #10 select_2 = 0;

        #50 $finish;
    end

endmodule
