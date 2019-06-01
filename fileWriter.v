module fileWriter(input clk, input [31:0] A, input cen);
    integer               data_file    ; // file handler
    integer               scan_file    ; // file handler
    `define NULL 0    

    initial begin
        data_file = $fopen("results.dat", "w");
        
    if (data_file == `NULL) begin
        $display("data_file handle was NULL");
        $finish;
    end
    end

    always @(posedge clk) begin
        if(cen == 1'b1) begin
            if (^A === 1'bx) begin
            end
            else
                $fdisplay(data_file, "%b", A);
        end
    end
endmodule