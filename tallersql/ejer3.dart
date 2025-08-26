import 'dart:io';

void main() {
  // solicito los datos
  stdout.write("ingrese el origen:");
  String origen = stdin.readLineSync()!;

  stdout.write("ingrese el destino:");
  String destino = stdin.readLineSync()!;

  stdout.write("ingrese la distancia en km:");
  double distancia = double.parse(stdin.readLineSync()!);

  // PIDO EL MEDIO DE TRANSPORTE
  print("Seleccione el medio de transporte:");
  print("1. A pie");
  print("2. Bicicleta");
  print("3. carro");
  print("4. transporte publico");
  int medioTransporte = int.parse(stdin.readLineSync()!);

  //pido la condicion del trafico
  print("Seleccione la condicion del trafico:");
  print("1. hora pico ");
  print("2. normal");
  int condicionTrafico = int.parse(stdin.readLineSync()!);

//variables
double velocidad =0;  // en km/h
double costo =0; // en horas

if (medioTransporte == 1) {
    velocidad = 5;
    costo = 0;
  } else if (medioTransporte == 2) {
    velocidad = 15;
    costo = 0;
  } else if (medioTransporte == 3) {
    velocidad = 60;
    costo = distancia * 0.2;
   
  } else if (medioTransporte == 4) {
    velocidad = 40;
    costo = 2500; // tarifa fija estimada
  } else {
    print("medio de transporte no valido");
    return; // salir del programa si el medio de transporte no es valido
  }
  // calcular velocidade segun el trafico
  if (condicionTrafico ==1){
  velocidad *=0.7;
}
// calcular el tiempo
double tiempo = distancia / velocidad;
double tiempoMinutos = tiempo * 60;

 
  // muestro los resultados
  print("\n--- Resultado ---");
  print("Origen: $origen");
  print("Destino: $destino");
  print("Distancia: ${distancia.toStringAsFixed(2)} km");
  print("Medio de transporte: $medioTransporte");
  print("Condicion del trafico: $condicionTrafico");
  print("Tiempo estimado: ${tiempo.toStringAsFixed(2)} horas");
  print("Costo total: \$${costo.toStringAsFixed(2)}");
}