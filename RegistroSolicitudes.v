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
	input shift_in,
	input [9:0] entrada, 
	input carga, 
	input shift_en, 
	output shift_out, 
	output[9:0] contenido
	);
	
	reg [9:0] shift_reg;
	
	always @(posedge clk)
		if(carga)
			shift_reg <= entrada;
		else if (shift_en)
			shift_reg <= {shift_reg[8:0], shift_in};
		assign shift_out = shift_reg[9];
		assign contenido = shift_reg;
		
endmodule
