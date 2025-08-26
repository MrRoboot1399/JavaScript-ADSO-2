import 'dart:io';

// Clase que representa una notificación
class Notificacion {
  String titulo;
  String mensaje;
  String tipo; // info, advertencia, error
  DateTime fechaHora;
  bool leida;

  Notificacion(this.titulo, this.mensaje, this.tipo)
    : fechaHora = DateTime.now(),
      leida = false;

  void marcarComoLeida() {
    leida = true;
  }

  void mostrar() {
    print(
      "[${tipo.toUpperCase()}] $titulo - $mensaje (${fechaHora.toLocal()}) ${leida ? "(LEÍDA)" : "(NO LEÍDA)"}",
    );
  }
}

// Clase que maneja varias notificaciones
class GestorNotificaciones {
  List<Notificacion> notificaciones = [];

  void agregar(Notificacion n) {
    notificaciones.add(n);
  }

  void mostrarTodas() {
    print("\n=== LISTA DE NOTIFICACIONES ===");
    if (notificaciones.isEmpty) {
      print("No hay notificaciones.");
    } else {
      for (var n in notificaciones) {
        n.mostrar();
      }
    }
  }

  void filtrarPorTipo(String tipo) {
    print("\n=== NOTIFICACIONES DE TIPO: ${tipo.toUpperCase()} ===");
    var filtradas = notificaciones.where((n) => n.tipo == tipo).toList();

    if (filtradas.isEmpty) {
      print("No hay notificaciones de este tipo.");
    } else {
      for (var n in filtradas) {
        n.mostrar();
      }
    }
  }

  void mostrarEstadisticas() {
    int total = notificaciones.length;
    int leidas = notificaciones.where((n) => n.leida).length;
    int noLeidas = total - leidas;

    print("\n=== ESTADÍSTICAS ===");
    print("Total: $total");
    print("Leídas: $leidas");
    print("No leídas: $noLeidas");

    // estadísticas por tipo
    var tipos = ["info", "advertencia", "error"];
    for (var t in tipos) {
      int count = notificaciones.where((n) => n.tipo == t).length;
      print("$t: $count");
    }
  }
}

void main() {
  var gestor = GestorNotificaciones();

  // Crear notificaciones de prueba
  gestor.agregar(
    Notificacion("Bienvenida", "Hola, gracias por usar la app", "info"),
  );
  gestor.agregar(
    Notificacion(
      "Alerta de seguridad",
      "Tu contraseña es débil",
      "advertencia",
    ),
  );
  gestor.agregar(
    Notificacion(
      "Error de conexión",
      "No se pudo conectar al servidor",
      "error",
    ),
  );

  gestor.mostrarTodas();

  // Marcar la segunda como leída
  gestor.notificaciones[1].marcarComoLeida();

  gestor.filtrarPorTipo("advertencia");
  gestor.mostrarEstadisticas();
}
