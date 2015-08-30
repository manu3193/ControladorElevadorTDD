//Se define que el tiempo en que la puerta estar abierta como maximo es de 10seg

//Modulo del temporizador
module Temporizador_Divisor (
		input  C_100Mhz, //Clock de la fpga = 100MHz
		input  startTimer,
		input  restart,
		output reg C_1Hz
		/*,
		output reg timeExpired   
		*/
	);
/*
	reg timeExpired; //1 expirado, 0 no expirado
	reg C_1Hz = 1;  //Seal de salida (<em>Se debe asignar un estado lgico</em>).
	*/ 
	reg[31:0] contador = 0; //Variable Contador equivale a 25 millones de estados. 
	 
	always @(posedge C_100Mhz)
		begin
			if (startTimer)
				begin
				if(restart) //reinicia
					begin
					contador <= 0;
					C_1Hz <= 1'b0;
					end
				if (contador == 100000000)          //Si ha cuenta 1s enciende led
					begin
					C_1Hz <= 1'b1;
					end
				if (contador == 200000000)          //Si cuenta otro segundo lo apaga y reinicia
					begin
					C_1Hz <= 1'b0;
					contador <=0;
					end
				else
					begin
					contador <= contador + 1;        //suma contador
				   end
				end
	  end
endmodule
