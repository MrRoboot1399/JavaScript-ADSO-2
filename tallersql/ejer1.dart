import 'dart:io';

void main() {
  // se pide el valor del pedido y se muestra en pantalla
  stdout.write('escriba el valor de su pedido:');
  double pedido = double.parse(stdin.readLineSync()!);
  print('el valor de su pedido es: $pedido');

  //se pide el tipo de servicio y se guarda en una variable'
  print(
    'selecione el tipo de servicio:\n'
    '\t1. Comida\n'
    '\t2. Farmacia\n'
    '\t3. Supermercado\ningresa el numero de opcion',
  );

  int tipoServicio = int.parse(stdin.readLineSync()!);

  // se pide la calidad del servicio
  print('selecione la calidad de servicio:');
  print('1. excelente 20%');
  print('2. bueno 15%');
  print('3. regular 10%');
  int calidad = int.parse(stdin.readLineSync()!);

  // estructura if igual a switch
  /*double porcentaje;
  if (calidad == 1) {
    porcentaje = 0.20;
  } else if (calidad == 2) {
    porcentaje = 0.15;
  } else {
    porcentaje = 0.10;
  }*/
  double porcentaje;
  porcentaje = 0.0;
  switch (calidad) {
    case 1:
      porcentaje = 0.20;
      break;
    case 2:
      porcentaje = 0.15;
      break;
    case 3:
      porcentaje = 0.10;
      break;
    default:
      print('opcion no valida, se asigna 0% de propina');
  }
  double propinas = pedido * porcentaje;
  double total = pedido + propinas;

  //resultados
  print('--- Resultado ---');
  print('Valor pedido: $pedido');
  print('Propina: \$${propinas.toStringAsFixed(2)}');
  print('Total a pagar: \$${total.toStringAsFixed(2)}');
}