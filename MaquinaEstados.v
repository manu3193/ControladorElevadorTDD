`timescale 1ns / 1ps


module MaquinaEstados(
    clk, //Clock de la maquina de estados
	 reset, //Reset de la maquina de estados
	 state, //para la maquina de estados
	 
	 overweight,//Indicador de sobrepeso (1: si hay, 0 no hay)
	 jammedDoor,//Indicador de puerta atascada (1: atascado, 0 libre)
	 
	 //SPS, SP1, SP2, SP3, SP4, //Solicitudes de piso
	 
	 motor, //Led que muestra que el motor está encendido (1:ENCENDIDO, 0:APAGADO)
	 brake, //Led que muestra que los frenos están activados (1:ACTIVADOS, 0:DESACTIVADOS)
	 openDoor, //Led que muestra que la puerta se abre (1:ABIERTA, 0:CERRADA)
	 
    );
	 
	 //Entradas del controlador
	 input clk, reset;
	 input overweight, jammedDoor;
	 //input SPS, SP1, SP2, SP3, SP4;
	 
	 //Tiempo expirado (1:ACTIVADO, 0:DESCATIVADO)
	 reg timeExpired;
	 
	 //Salidas del controlador
	 output motor, brake, openDoor;
	 
	 
	 //Regitro de solicitudes de cada piso ¿¿¿¿¿¿¿¿¿¿¿ (No ensamblado aun)?????????????????
	 reg[1:0] floorSRegister;
	 reg[1:0] floor1Register;
	 reg[1:0] floor2Register;
	 reg[1:0] floor3Register;
	 reg[1:0] floor4Register;
	 
	 //--------------Todo para el 7 segementos-------------------
	 
	 reg A, B, C; //cambia depende de lo que pase en la maquina de estados
	 reg o1,o2,o3,o4,o5,o6,o7; //Las salidas cambian depende de los 3 registros anteriores
										//
		
	always @(o1,o2,o3,o4,o5,o6,o7)
		begin 
			o1 = !( (!C&!A) | B ); 
			o2 = 1'b0;
			o3 = !( (!B) | C );
			o4 = !( (!A&!C) | B );
			o5 = !( (!A&!C) | (B&!C) );
			o6 = !( A | (!B&!C) );
			o7 = !( A | B ); 
			
		end
			
	 //Siempre están en cero
	 assign an1 = 1'b0;
	 assign an2 = 1'b0;
	 assign an3 = 1'b0;
	 assign an4 = 1'b0;
	 	 
	 
	 //----------------------------------------------------------
	 
	 //---------------AHORA LA MAQUINA DE ESTADOS-----------------
	 
	 output [1:0] state;
	 reg[1:0] state, nextState;
	 reg[1:0] solicitud;
	 reg motor, openDoor, brake;
	 
	 
	 parameter reposo = 0;
	 parameter esperaPasajeros = 1;
	 parameter revisaSeguridad = 2;
	 parameter movimiento = 3;

	 //Asignación sincrona del siguiente estado
	 always @(posedge clk or negedge reset)
		if (!reset)
			state <= reposo;
		else 
			state <= nextState;
	
	//Asignación asincrona de cada estado
	always @(state or solicitud)
	
	begin
		case (state)
		
			reposo:
			
				if ( !solicitud )
					begin
					motor = 1'b0;
					brake = 1'b1;
					openDoor = 1'b0;
					
					nextState = reposo;
					end
				else
					nextState = esperaPasajeros;
				
			esperaPasajeros:
			
				if ( (overweight | jammedDoor) & !timeExpired )
					begin
					openDoor = 1'b1;
					//El timer comienza
					motor = 1'b0;
					brake = 1'b1;
				
					nextState = esperaPasajeros;
					end 
				else if ( timeExpired )
					nextState = revisaSeguridad;
				else if ( !solicitud & timeExpired )
					nextState = reposo;
				
			revisaSeguridad:
				
				if (jammedDoor | overweight)
					nextState = esperaPasajeros;
				else if ( !(jammedDoor | overweight) )
					nextState = movimiento;
			
			movimiento:
				
				if (solicitud)
					begin
					motor = 1'b1;
					brake = 1'b0;
					openDoor = 1'b0;
				
					nextState = movimiento;
					end 
				else
					nextState = esperaPasajeros;
			
		endcase
	end
	 
	
endmodule
