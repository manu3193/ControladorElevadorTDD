//Se define que el tiempo en que la puerta estará abierta como maximo es de 10seg

//Modulo del temporizador
module Temporizador_Divisor (
		input C_100Mhz, //Clock de la fpga = 100MHz
		input startTimer,
		input restart,
		output C_1Hz,
		output timeExpired
	);

	reg timeExpired; //1 expirado, 0 no expirado
	reg C_1Hz = 1;  //Señal de salida (<em>Se debe asignar un estado lógico</em>).
	 
	reg[24:0] contador = 0; //Variable Contador equivale a 25 millones de estados. 
	 
	always @(posedge C_100Mhz)
		begin
			if (startTimer)
				begin
				contador = contador + 1; //0.5 segundos LED encendido
				if(contador == 25_000_000 | restart) //25000000 por vara
					begin
					contador = 0;
					C_1Hz = ~C_1Hz; //0.5 segundos LED apagado
					end
				if (contador == 10)
					begin
					timeExpired = 1'b1;
					contador = 0;
					end
				end
	  end
endmodule
