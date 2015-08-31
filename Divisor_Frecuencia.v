`timescale 1ns / 1ps
//Se define que el tiempo en que la puerta estar abierta como maximo es de 10seg

//Modulo del divisor de frecuencia
module Divisor_Frecuencia (
		input  C_100Mhz, //Clock de la fpga = 100MHz
		output  C_1Hz
	);

	reg[31:0] contador = 0; //Variable que almacena Contador
	reg C_1Hz=0;
	 
	always @(posedge C_100Mhz)
		begin
				if (contador == 50000000-1)          //Si ha cuenta 1s enciende led
					begin
					C_1Hz <= ~C_1Hz;
					contador <=0;
					end
				/*if (contador == 200000000-1)          //Si cuenta otro segundo lo apaga y reinicia
					begin
					C_1Hz <= 1'b0;
					contador <=0;
					end*/
				else
					begin
					contador <= contador + 1;        //suma contador
				   end
	  end
endmodule
