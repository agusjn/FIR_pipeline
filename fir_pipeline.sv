/////////////////////////////////////////////////////////correct
module FIR_1k (
    input logic clk, reset_n,
    input logic signed [23:0] data_in,
    output logic signed [23:0] data_out
);
integer i, j, k;
parameter N = 48;
reg signed [15:0] taps [0:N-1] = '{ 
//add your coefficiences
};

reg signed [23:0] delay [0:N-1];
reg signed [39:0] cof [0:N-1];
reg signed [23:0] delay2;
reg signed [40:0] delay3 [0:N-2];  
always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
            for(i = 0; i < N; i = i + 1) begin
                delay[i] <= 0;
            end
    end
    else begin
            delay[0] <= data_in;
            for(i = 1; i < N; i = i + 1) begin
                delay[i] <= delay[i-1];
            end
    end  
    end   
always @(posedge clk or negedge reset_n) begin   
    if(!reset_n) begin
        for (j = 0; j < N; j = j+1 ) begin
      cof[j] <= 0;    
        end
    end
    else begin
    for (j = 0; j < N; j = j+1 ) begin
      cof[j] <= delay[j] * taps[j];
    end
    end

end

always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
    delay2 <= 0;
    end
    else begin
    delay2 <= cof[N-1];
    end
end

always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        for(k = 0; k < N-1; k=k+1) begin
            delay3[i] <= 0;
        end

    end else begin 
    delay3[N-2] <= delay2 + cof[N-2]; 
    //for(i=N-2; i > 0; i = i-1 )
        for(k=N-2; k > 0; k=k-1) begin
                delay3[k-1] <= delay3[k] + cof[k-1];
        end
    end
end
    always @(delay3[0]) begin
    if(!reset_n) begin
            data_out = 0;
    end
    else begin
        data_out = $signed (delay3[0][40:17]) ;
    end
    end
endmodule
