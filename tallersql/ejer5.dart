import 'dart:io';

void main() {
  // 1) Solicitar monto de compra
  stdout.write("Ingrese el monto de la compra: ");
  double monto = double.parse(stdin.readLineSync() ?? "0");

  // 2) Definir el descuento según rangos
  double descuento = 0;

  if (monto >= 0 && monto <= 50) {
    descuento = 0;
  } else if (monto >= 51 && monto <= 100) {
    descuento = 0.05;
  } else if (monto >= 101 && monto <= 200) {
    descuento = 0.10;
  } else if (monto >= 201) {
    descuento = 0.15;
  }

  // 3) Calcular valores
  double ahorro = monto * descuento;
  double subtotal = monto - ahorro;
  double iva = subtotal * 0.19;
  double totalFinal = subtotal + iva;

  // 4) Mostrar resultados
  print("\n=== Resultado de la compra ===");
  print("Monto de compra: \$${monto.toStringAsFixed(2)}");
  print("Descuento aplicado: ${(descuento * 100).toStringAsFixed(0)}%");
  print("Ahorro: \$${ahorro.toStringAsFixed(2)}");
  print("Subtotal (con descuento): \$${subtotal.toStringAsFixed(2)}");
  print("IVA (19%): \$${iva.toStringAsFixed(2)}");
  print("Total a pagar: \$${totalFinal.toStringAsFixed(2)}");
}
