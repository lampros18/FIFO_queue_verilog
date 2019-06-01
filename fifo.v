module FIFO(input clk, input Cen, input reset, input [31:0] Data_in, input [31:0] Cipher_key, input QUEUE_Read_Write, output reg QUEUE_Empty, output reg QUEUE_Full, output reg QUEUE_Last, output reg [31:0] QUEUE_Data_Out);

parameter FIFO_LENGTH = 31,
          FIFO_DEPTH = 47;

reg [FIFO_LENGTH:0] data [FIFO_DEPTH:0];
integer finish;
integer i;
initial begin
    for ( i = 0; i <= FIFO_DEPTH; i++ ) begin
        data[i] = 32'b00000000_00000000_00000000_00000000;    
    end
    finish = -1;
    QUEUE_Empty = 1'b1;
    QUEUE_Last = 1'b0;
    QUEUE_Full = 1'b0;
end
always @(posedge clk or reset) begin
    if (Cen == 1'b1) begin
        if(reset == 1'b0)begin
            
            if(^QUEUE_Read_Write === 1'bX) begin
                QUEUE_Empty = 1'b1;
            end
            else if(QUEUE_Read_Write == 1'b0 && clk == 1'b1) begin //read Data
        
                //0 Check if queue is empty
                if( finish > -1 ) begin
                    // 1 write data to QUEUE_Data_Out
                    QUEUE_Data_Out = data[0] ^ Cipher_key;
                    // Shift all elements
                    for (i = 0; i < finish; i++)
                        data[i] = data[i+1];
                    
                    finish = finish -1;

                    if (finish == -1) begin
                        QUEUE_Empty = 1'b1;
                    end

                    if (finish == FIFO_DEPTH - 1) begin
                        QUEUE_Last = 1'b1;
                        QUEUE_Full = 1'b0;
                    end

                    if ( finish < FIFO_DEPTH - 1 ) begin
                        QUEUE_Last = 1'b0;
                    end

                end
                else begin
                    QUEUE_Empty = 1'b1;
                end

            end
            
            else if( QUEUE_Read_Write == 1'b1 && clk == 1'b1) begin //write data
                if ( finish != FIFO_DEPTH ) begin
                    finish = finish + 1;
                    data[finish] = Data_in ^ Cipher_key;
                    if(QUEUE_Empty == 1'b1) begin
                        QUEUE_Empty = 1'b0;
                    end

                    if( finish == FIFO_DEPTH - 1 ) begin
                        QUEUE_Last = 1'b1;
                    end

                    if( finish == FIFO_DEPTH ) begin
                        QUEUE_Last = 1'b0;
                        QUEUE_Full = 1'b1;
                    end 
                end

            end

        end
        if (reset == 1'b1) begin
            for(i = 0; i <= FIFO_DEPTH ; i++)
                data[i] = 32'b00000000_00000000_00000000_00000000;
            finish = -1;
            QUEUE_Empty = 1'b1;
            QUEUE_Last = 1'b0;
            QUEUE_Full = 1'b0;
        end
    end    
end
endmodule