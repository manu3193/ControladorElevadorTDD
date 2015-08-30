`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:31:03 08/26/2015 
// Design Name: 
// Module Name:    RegistroSolicitudes 
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


	/*
	 *Este modulo se encarga de registrar las solucitudes de todos los pisos
	 *implementando un banco de 5 registros de 2 bits secuenciales, activados 
	 *por un mismo reloj.
	 *Tiene como entrada 5 pares de 2 bits.
	 *
	 */
module RegistroSolicitudes(
   input clk, 
	input ShiftIn,
	input [2:0] ParallelIn, 
	input load, 
	input ShiftEn, 
	output ShiftOut, 
	output[2:0] RegContent
	);
	
	reg [2:0] shift_reg;
	
	always @(posedge clk)
		if(load)
			shift_reg <= ParallelIn;
		else if (ShiftEn)
			shift_reg <= {shift_reg[1:0], ShiftIn};
		assign ShiftOut = shift_reg[2];
		assign RegContent = shift_reg;
		
endmodule
