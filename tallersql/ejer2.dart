import 'dart:io';

void main(){
  // se pide la contrasña
  stdout.write("escriba por favor su contrasena: ");
  String contrasena = stdin.readLineSync()!;

  // condiciones de la contrasña
  bool tieneMayuscula = contrasena.contains(RegExp(r'[A-Z]'));
  bool tieneMinuscula = contrasena.contains(RegExp(r'[a-z]'));
  bool tieneNumero = contrasena.contains(RegExp(r'[0-9]'));
  bool tieneCaracterEspecial = contrasena.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool longitudValida = contrasena.length >= 8;

  // calculamos puntaje
  int puntaje = 0;
  if (tieneMayuscula) puntaje++;
  if (tieneMinuscula) puntaje++;  
  if (tieneNumero) puntaje++;
  if (tieneCaracterEspecial) puntaje++;
  if (longitudValida) puntaje++;

  // evaluamos seguridad de la contra
  String nivelSeguridad;
  if (puntaje <=2){
    nivelSeguridad = "debil";
  } else if  (puntaje == 3){
    nivelSeguridad = "media";
  } else if (puntaje == 4){
    nivelSeguridad = "fuerte";
  } else {
    nivelSeguridad = "muy fuerte";
  }
  print("\nResultado:");               // Muestra resultados: 
  print("Contraseña: $contrasena");      // Imprime la contraseña que escribió el usuario
  print("Nivel de seguridad: $nivelSeguridad"); // Imprime el nivel de seguridad calculado


    // Sugerencias de mejora
  print("\nSugerencias:");
  if (!longitudValida) print("- Usa al menos 8 caracteres.");
  if (!tieneMayuscula) print("- Agrega letras mayúsculas.");
  if (!tieneMinuscula) print("- Agrega letras minúsculas.");
  if (!tieneNumero) print("- Agrega números.");
  if (!tieneCaracterEspecial) print("- Agrega caracteres especiales como !, @, #, etc.");
  
}
