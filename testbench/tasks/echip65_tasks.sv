///////////////////////////////////////////////////////////////////
// File Name: echip65_tasks.sv
// Engineer:  Carl Grace (crgrace@lbl.gov)
// Description: Tasks for simulating echip65 RTL 
//          
///////////////////////////////////////////////////////////////////

// check digital monitor
task checkMonitor;
    logic [24:0] monitor_expected;
    for (int index = 0; index < 16; index++) begin
//       @(negedge clk);  // wait for monitor to be latched
        digital_monitor_sel = index;
        repeat (500)
            @(negedge clk);
        case (digital_monitor_sel)
            4'b0000: monitor_expected = 'b0;
            4'b0001: monitor_expected = {24'b0, cic3_echip65.in};
            4'b0010: monitor_expected = cic3_echip65.in_coded;
            4'b0011: monitor_expected = cic3_echip65.acc1;
            4'b0100: monitor_expected = cic3_echip65.acc2;
            4'b0101: monitor_expected = cic3_echip65.acc3;
            4'b0110: monitor_expected = cic3_echip65.acc3_d;
            4'b1111: monitor_expected = cic3_echip65.diff1;
            4'b1000: monitor_expected = cic3_echip65.diff1_d;
            4'b1001: monitor_expected = cic3_echip65.diff2;
            4'b1010: monitor_expected = cic3_echip65.diff2_d;
            4'b1011: monitor_expected = cic3_echip65.diff3;
            4'b1100: monitor_expected = {17'b0,cic3_echip65.clock_counter};
            4'b1101: monitor_expected = cic3_echip65.divided_clk;
            4'b1110: monitor_expected = cic3_echip65.out;
            4'b1111: monitor_expected = 'b1;
        endcase        
        @(negedge clk);  // wait for monitor to be latched
        assert (monitor_expected == digital_monitor) 
            $display("MONITOR TEST, select = %d, PASS",digital_monitor_sel);
        else begin
            $display("MONITOR TEST, select = %d, FAIL",digital_monitor_sel);
            $display("Expected = %h, observed = %h",monitor_expected,digital_monitor);
            $display("\n");
        end // assert
    end // for
    $display("%m: Digital Monitor Test Complete");
endtask : checkMonitor

