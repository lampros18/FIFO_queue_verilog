`include "fifo.v"
`include "clock.v"
`include "fileReader.v"
`include "fileWriter.v"

module top();
reg Cen, reset, QUEUE_Read_Write, rcen, restartfpread, restartfp, ciphcen, ciphcenw, wcen;
wire [31:0] Data_in;
reg [31:0] Cipher_key;
wire QUEUE_Empty, QUEUE_Full, QUEUE_Last;
wire [31:0]QUEUE_Data_Out;
wire clk;

Clock myclock(.clk(clk));

// fileReader fr(clk, Data_in, rcen, restartfpread);
FIFO myfifo(.clk(clk), .Cen(Cen), .reset(reset), .Data_in(Data_in), .Cipher_key(Cipher_key), .QUEUE_Read_Write(QUEUE_Read_Write), .QUEUE_Empty(QUEUE_Empty), .QUEUE_Full(QUEUE_Full), .QUEUE_Last(QUEUE_Last), .QUEUE_Data_Out(QUEUE_Data_Out));

// fileWriter fw(clk, QUEUE_Data_Out, wcen);
fileWriter fw(clk, QUEUE_Data_Out, wcen);

// fileWriterCipher fwc(clk, QUEUE_Data_Out, ciphcenw);

// fileReaderCipher frc(clk, Cipher_key, ciphcen, restartfp);

fileReader49 fr(clk, Data_in, rcen, restartfpread);

initial begin
    $display("\t\t\tCLOCK|ENABLED|RESET|DATA_IN|CIPHER_KEY|QUEUE_READ_WRITE|QUEUE_EMPTY|QUEUE_LAST|QUEUE_FULL|DATA_OUT");
    $monitor($time,"||%b||%b||%b||%b||%b||%b||%b||%b||%b||%b", clk, Cen, reset, Data_in, Cipher_key, QUEUE_Read_Write, QUEUE_Empty, QUEUE_Last, QUEUE_Full, QUEUE_Data_Out);
    /*Test case 1 - Insert 48 rows to the queue, using the same cipher key*/

    // Cen = 1'b1;
    // reset = 1'b0;
    // restartfpread = 1'b0;
    // Cipher_key = 32'b11110010001100000000010111111010;
    // rcen = 1'b1;
    // #2 QUEUE_Read_Write=1'b1;
    // #96 QUEUE_Read_Write = 1'b0;
    // #96 $finish;

    /*Test case 2 - Insert 48 rows to the queue, using 48 different cipher keys*/
    // Cen = 1'b1;
    // reset = 1'b0;
    // restartfpread = 1'b0;
    // restartfp = 1'b0;
    // rcen = 1'b1;
    // ciphcen = 1'b1;
    // #2 QUEUE_Read_Write=1'b1;
    // #96 QUEUE_Read_Write = 1'b0;restartfp = 1'b1;ciphcenw=1'b1;
    // #96 $finish;

    /*Test case 1 - Insert 49 rows to the queue, using the same cipher key*/
    Cen = 1'b1;
    reset = 1'b0;
    restartfpread = 1'b0;
    Cipher_key = 32'b11110010001100000000010111111010;
    rcen = 1'b1;
    #2 QUEUE_Read_Write=1'b1;
    #98 QUEUE_Read_Write = 1'b0;rcen=1'b0;wcen=1'b1;
    #98 $finish;


end

endmodule





