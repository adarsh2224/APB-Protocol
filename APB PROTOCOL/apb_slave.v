`define DATAWIDTH 32
`define ADDRWIDTH 8
`define DEPTH 256
`define IDLE     2'b00
`define WRITE_STATE  2'b01
`define READ_STATE  2'b10
module apb_slave
(
  input                         PCLK,
  input                         PRESETn,
  input                         PENABLE,
  input        [`ADDRWIDTH-1:0] PADDR,
  input                         PWRITE,
  input                         PSEL,
  input        [`DATAWIDTH-1:0] PWDATA,
  output reg   [`DATAWIDTH-1:0] PRDATA,
  output reg                    PREADY
);

  reg [`DATAWIDTH-1:0] mem [0:`DEPTH-1];

reg [1:0] State;



always @(posedge PCLK or negedge PRESETn) begin
  if (!PRESETn) begin
    State  <= `IDLE;
    PRDATA <= 0;
    PREADY <= 0;
  	end 
	else begin

    PREADY <= 0;

    case (State)

      `IDLE: begin
        if (PSEL) begin
          if (PWRITE)
            State <= `WRITE_STATE;
          else
            State <= `READ_STATE;
        end
      end

      `WRITE_STATE: begin
        if (PSEL && PENABLE && PWRITE) begin
          mem[PADDR] <= PWDATA;
          PREADY <= 1;
          State <= `IDLE;
        end
      end

      `READ_STATE: begin
        if (PSEL && PENABLE && !PWRITE) begin
          PRDATA <= mem[PADDR];
          PREADY <= 1;
          State <= `IDLE;
        end
      end

      default: State <= `IDLE;

    endcase
  end
end
endmodule
