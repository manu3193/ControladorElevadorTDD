`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:37:41 08/26/2015
// Design Name:   DecoBCDto7seg
// Module Name:   /home/manzumbado/Development/HDL/Xilinx/ControladorElevadorTDD/trunk/DecoGreytoBCD.v
// Project Name:  ControladorElevadorTDD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DecoBCDto7seg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//Decodificador que convierte código grey de 3 bits en código binario
module DecoGreytoBCD(
	entradas_i,	//3 bits de entrada
	salidas_o //3 bits de salida
	);
	
	input [2:0] entradas_i;
	output [2:0] salidas_o;
	
	//wire entradas_i;
	//wire salidas_o;
	
	//Aqui se hace la transformación
	assign salidas_o[0] = entradas_i[0];
	xor xorB(salidas_o[1], entradas_i[0], entradas_i[1]);
	xor xorC(salidas_o[2], salidas_o[1], entradas_i[2]);
	
	
endmodule

