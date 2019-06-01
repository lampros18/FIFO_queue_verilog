module fileReader(input clk, output reg [31:0] data, input cen, input restart);
    integer               data_file    ; // file handler
    integer               scan_file    ; // file handler
    reg                    flag;
    reg [31:0] captured_data;
    `define NULL 0    

    initial begin
        data_file = $fopen("data_file.dat", "r");
        flag = 1'b1;
    if (data_file == `NULL) begin
        $display("data_file handle was NULL");
        $finish;
    end
    end

    always @(negedge clk) begin
        if(restart == 1'b1 && flag == 1'b1)begin
            scan_file =  $rewind(data_file);
            flag = 1'b0;
        end
        if(cen == 1'b1) begin
            scan_file = $fscanf(data_file, "%b;", captured_data); 
            if (!$feof(data_file)) begin
                data = captured_data;
            end
            else
            begin
                $display("feof");
            end
        end
    end
endmodule

module fileReaderCipher(input clk, output reg [31:0] data, input cen, input restart);
    integer               data_file    ; // file handler
    integer               scan_file    ; // file handler
    reg                     flag;
    reg                     flag2;
    reg [31:0] captured_data;
    `define NULL 0    

    initial begin
        data_file = $fopen("cipher_keys.dat", "r");
        flag = 1'b1;
        flag2 = 1'b1;
    if (data_file == `NULL) begin
        $display("data_file handle was NULL");
        $finish;
    end
    end

    always @(negedge clk) begin
        if (restart == 1'b1 && flag == 1'b1) begin
            scan_file = $rewind(data_file);
            flag = 1'b0;
        end
        if(cen == 1'b1) begin
            scan_file = $fscanf(data_file, "%b;", captured_data); 
            if (!$feof(data_file)) begin
                data = captured_data;
            end
            else
            begin
                $display("feof");
            end
        end
    end
endmodule

module fileReader49(input clk, output reg [31:0] data, input cen, input restart);
    integer               data_file    ; // file handler
    integer               scan_file    ; // file handler
    reg                    flag;
    reg [31:0] captured_data;
    `define NULL 0    

    initial begin
        data_file = $fopen("data_file49.dat", "r");
        flag = 1'b1;
    if (data_file == `NULL) begin
        $display("data_file handle was NULL");
        $finish;
    end
    end

    always @(negedge clk) begin
        if(restart == 1'b1 && flag == 1'b1)begin
            scan_file =  $rewind(data_file);
            flag = 1'b0;
        end
        if(cen == 1'b1) begin
            scan_file = $fscanf(data_file, "%b;", captured_data); 
            if (!$feof(data_file)) begin
                data = captured_data;
            end
            else
            begin
                $display("feof");
            end
        end
    end
endmodule