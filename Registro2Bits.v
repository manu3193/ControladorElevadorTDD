`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:19 08/31/2015 
// Design Name: 
// Module Name:    Registro2Bits 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Registro2Bits(_clk_, datos_i/*, load_en*/, clear_i, salida_o
    );
	
	input _clk_, clear_i/*, load_en*/;
	input [1:0] datos_i;
	output reg [1:0] salida_o;
	
	always @(posedge _clk_) begin
		
		if(clear_i) 
			salida_o<=2'b00;
		else //if(load_en)
			salida_o<= datos_i|salida_o;
	end
	

endmodule
