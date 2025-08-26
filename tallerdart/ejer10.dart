import 'dart:io';

// Clase Reseña
class Resena {
  String usuario;
  int calificacion; // 1 a 5 estrellas
  String comentario;
  DateTime fecha;
  int utilidad; // número de votos útiles

  Resena(this.usuario, this.calificacion, this.comentario, {this.utilidad = 0})
    : fecha = DateTime.now();

  void marcarUtil() {
    utilidad++;
  }

  void mostrar() {
    print(
      "[$calificacion ★] $usuario - \"$comentario\" (${fecha.toLocal()}) | Utilidad: $utilidad",
    );
  }
}

// Clase GestorReseñas
class GestorResenas {
  List<Resena> resenas = [];

  void agregar(Resena r) {
    resenas.add(r);
    print("Reseña de '${r.usuario}' agregada correctamente.");
  }

  void mostrarTodas() {
    print("\n=== LISTA DE RESEÑAS ===");
    if (resenas.isEmpty) {
      print("No hay reseñas registradas.");
    } else {
      for (var r in resenas) {
        r.mostrar();
      }
    }
  }

  void calcularPromedio() {
    if (resenas.isEmpty) {
      print("\nNo hay reseñas para calcular el promedio.");
      return;
    }
    double promedio =
        resenas.fold(0, (suma, r) => suma + r.calificacion) / resenas.length;
    print("\nCalificación promedio: ${promedio.toStringAsFixed(2)} ★");
  }

  void filtrarPorEstrellas(int estrellas) {
    print("\n=== RESEÑAS DE $estrellas ESTRELLAS ===");
    var filtradas = resenas.where((r) => r.calificacion == estrellas);
    if (filtradas.isEmpty) {
      print("No hay reseñas con $estrellas estrellas.");
    } else {
      for (var r in filtradas) {
        r.mostrar();
      }
    }
  }

  void mostrarMasUtiles() {
    print("\n=== RESEÑAS MÁS ÚTILES ===");
    var ordenadas = [...resenas]
      ..sort((a, b) => b.utilidad.compareTo(a.utilidad));
    for (var r in ordenadas) {
      r.mostrar();
    }
  }

  void mostrarEstadisticas() {
    print("\n=== ESTADÍSTICAS DE RESEÑAS ===");
    int total = resenas.length;
    print("Total de reseñas: $total");

    for (int i = 1; i <= 5; i++) {
      int count = resenas.where((r) => r.calificacion == i).length;
      print("$i estrellas: $count");
    }
  }
}

void main() {
  GestorResenas gestor = GestorResenas();

  // Agregar reseñas de prueba
  gestor.agregar(
    Resena("Juan", 5, "Excelente aplicación, muy útil", utilidad: 10),
  );
  gestor.agregar(Resena("Ana", 4, "Funciona bien, pero puede mejorar"));
  gestor.agregar(Resena("Carlos", 2, "Se cierra constantemente", utilidad: 5));
  gestor.agregar(Resena("Luisa", 3, "Está bien, pero le faltan funciones"));

  // Mostrar todas
  gestor.mostrarTodas();

  // Calcular promedio
  gestor.calcularPromedio();

  // Filtrar reseñas por estrellas
  gestor.filtrarPorEstrellas(5);

  // Mostrar reseñas más útiles
  gestor.mostrarMasUtiles();

  // Mostrar estadísticas
  gestor.mostrarEstadisticas();
}
