import 'dart:io';

void main() {
  // 1) Entradas
  stdout.write("Nombre de la red (SSID): ");
  String ssid = stdin.readLineSync() ?? "";

  stdout.write("Tipo de seguridad (WPA/WEP/abierta): ");
  String tipo = (stdin.readLineSync() ?? "").trim().toUpperCase();

  String password = "";
  if (tipo != "ABIERTA" && tipo != "NOPASS") {
    stdout.write("Contraseña: ");
    password = stdin.readLineSync() ?? "";
  }

  // 2) Validación básica
  if (ssid.isEmpty) {
    print("Error: el SSID no puede estar vacío.");
    return;
  }

  // Normalizamos tipo
  String t;
  if (tipo == "WPA") {
    t = "WPA";
  } else if (tipo == "WEP") {
    t = "WEP";
  } else {
    t = "nopass"; // red abierta
  }

  // 3) Reglas de contraseña (solo si no es abierta)
  bool segura = true;
  List<String> consejos = [];

  if (t != "nopass") {
    bool longitudValida = password.length >= 8;
    bool mayus = RegExp(r'[A-Z]').hasMatch(password);
    bool minus = RegExp(r'[a-z]').hasMatch(password);
    bool numero = RegExp(r'[0-9]').hasMatch(password);
    bool especial = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-\[\]\\;:/+]').hasMatch(password);

    if (!longitudValida) { segura = false; consejos.add("- Usa al menos 8 caracteres."); }
    if (!mayus)         { segura = false; consejos.add("- Incluye al menos una MAYÚSCULA."); }
    if (!minus)         { segura = false; consejos.add("- Incluye al menos una minúscula."); }
    if (!numero)        { segura = false; consejos.add("- Incluye al menos un número."); }
    if (!especial)      { segura = false; consejos.add("- Incluye un carácter especial (p.ej. !, @, #)."); }
  }

  // 4) Escapar caracteres especiales requeridos por el estándar
  String esc(String s) {
    return s
      .replaceAll(r'\', r'\\')
      .replaceAll(';', r'\;')
      .replaceAll(',', r'\,')
      .replaceAll(':', r'\:');
  }

  String ssidEsc = esc(ssid);
  String passEsc = esc(password);

  // 5) Construir string QR
  // H:false asume red visible (no oculta). Cámbialo a true si tu red es oculta.
  String qr;
  if (t == "nopass") {
    qr = "WIFI:T:nopass;S:$ssidEsc;H:false;;";
  } else {
    qr = "WIFI:T:$t;S:$ssidEsc;P:$passEsc;H:false;;";
  }

  // 6) Salida
  print("\n=== Resultado ===");
  print("Formato QR WiFi:");
  print(qr);

  if (t != "nopass") {
    print("\nSeguridad de la contraseña: ${segura ? "OK (aceptable)" : "Mejorable"}");
    if (!segura) {
      print("Sugerencias:");
      for (var c in consejos) print(c);
    }
  }

  // 7) Instrucciones de uso
  print("\n=== ¿Cómo usar este string? ===");
  print("- Copia el texto y genera el código QR en cualquier generador de QR (tipo “QR WiFi”).");
  print("- Asegúrate de seleccionar el tipo de seguridad correcto (WPA/WEP/abierta).");

  print("\nEn Android:");
  print("• Abre la app de Cámara o ‘Configuración > Wi-Fi > Agregar por QR’.");
  print("• Escanea el QR y acepta para conectarte.");

  print("\nEn iPhone (iOS):");
  print("• Abre la Cámara, apunta al QR y toca la notificación para unirte a la red.");

  print("\nNota:");
  print("• Si tu red es oculta, cambia H:false por H:true en el string antes de generar el QR.");
}
