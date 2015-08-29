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
	A_in,B_in,C_in,	//3 bits de entrada
	A_out, B_out, C_out //3 bits de salida
	);
	
	input A_in, B_in, C_in;
	output A_out, B_out, C_out;
	
	wire A_in, B_in, C_in;
	wire A_out, B_out, C_out;
	
	//Aqui se hace la transformación
	assign A_out = A_in;
	xor xorB(B_out, A_in, B_in);
	xor xorC(C_out, B_out, C_in);
	
	
endmodule

