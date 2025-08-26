import 'dart:io';

// Clase Lección
class Leccion {
  String titulo;
  String contenido;
  bool completada;

  Leccion(this.titulo, this.contenido) : completada = false;

  void marcarCompletada() {
    completada = true;
  }

  void mostrar() {
    print(" - $titulo ${completada ? '(Completada)' : '(Pendiente)'}");
  }
}

// Clase Curso
class Curso {
  String titulo;
  String categoria;
  List<Leccion> lecciones;
  List<int> calificaciones = [];

  Curso(this.titulo, this.categoria, this.lecciones);

  double obtenerPromedio() {
    if (calificaciones.isEmpty) return 0;
    return calificaciones.reduce((a, b) => a + b) / calificaciones.length;
  }

  void mostrar() {
    print("\nCurso: $titulo | Categoría: $categoria");
    print("Promedio calificación: ${obtenerPromedio().toStringAsFixed(2)} ★");
    for (var l in lecciones) {
      l.mostrar();
    }
  }
}

// Clase Progreso
class Progreso {
  Curso curso;
  int leccionesCompletadas = 0;

  Progreso(this.curso);

  void actualizarProgreso() {
    leccionesCompletadas = curso.lecciones.where((l) => l.completada).length;
  }

  double porcentaje() {
    if (curso.lecciones.isEmpty) return 0;
    return (leccionesCompletadas / curso.lecciones.length) * 100;
  }

  bool completado() {
    return leccionesCompletadas == curso.lecciones.length;
  }
}

// Clase Usuario
class Usuario {
  String nombre;
  List<Curso> cursosInscritos = [];
  Map<Curso, Progreso> progresoCursos = {};

  Usuario(this.nombre);

  void inscribirse(Curso curso) {
    cursosInscritos.add(curso);
    progresoCursos[curso] = Progreso(curso);
    print("$nombre se inscribió en el curso: ${curso.titulo}");
  }

  void completarLeccion(Curso curso, int indice) {
    if (!cursosInscritos.contains(curso)) {
      print("No estás inscrito en este curso.");
      return;
    }
    if (indice < 0 || indice >= curso.lecciones.length) {
      print("Lección inválida.");
      return;
    }
    curso.lecciones[indice].marcarCompletada();
    progresoCursos[curso]?.actualizarProgreso();
    print("Lección completada: ${curso.lecciones[indice].titulo}");
  }

  void verProgreso(Curso curso) {
    var progreso = progresoCursos[curso];
    if (progreso == null) {
      print("No estás inscrito en este curso.");
      return;
    }
    print(
      "Progreso en ${curso.titulo}: ${progreso.porcentaje().toStringAsFixed(2)}% (${progreso.leccionesCompletadas}/${curso.lecciones.length})",
    );
    if (progreso.completado()) {
      print("¡Curso completado! Certificado disponible para $nombre.");
    }
  }

  void calificarCurso(Curso curso, int estrellas) {
    if (!cursosInscritos.contains(curso)) {
      print("No puedes calificar un curso en el que no estás inscrito.");
      return;
    }
    if (estrellas < 1 || estrellas > 5) {
      print("La calificación debe estar entre 1 y 5 estrellas.");
      return;
    }
    curso.calificaciones.add(estrellas);
    print("$nombre calificó '${curso.titulo}' con $estrellas estrellas.");
  }

  void mostrarEstadisticas() {
    print("\n=== Estadísticas de $nombre ===");
    for (var curso in cursosInscritos) {
      verProgreso(curso);
    }
  }

  void recomendarCursos(List<Curso> disponibles) {
    print("\n=== Recomendaciones para $nombre ===");
    if (cursosInscritos.isEmpty) {
      print("Recomendación: inscríbete en tu primer curso.");
      return;
    }
    var ultimaCategoria = cursosInscritos.last.categoria;
    var sugeridos = disponibles
        .where(
          (c) => c.categoria == ultimaCategoria && !cursosInscritos.contains(c),
        )
        .toList();
    if (sugeridos.isEmpty) {
      print("No hay cursos recomendados en este momento.");
    } else {
      for (var c in sugeridos) {
        print("Recomendado: ${c.titulo} (${c.categoria})");
      }
    }
  }
}

void main() {
  // Crear cursos y lecciones
  var curso1 = Curso("Dart Básico", "Programación", [
    Leccion("Introducción", "Conceptos básicos de Dart"),
    Leccion("Variables", "Cómo declarar variables"),
    Leccion("Funciones", "Definición y uso de funciones"),
  ]);

  var curso2 = Curso("Flutter Intermedio", "Programación", [
    Leccion("Widgets", "Uso de widgets en Flutter"),
    Leccion("Estado", "Gestión de estado en aplicaciones"),
  ]);

  var curso3 = Curso("Nutrición Saludable", "Salud", [
    Leccion("Alimentación balanceada", "Conceptos básicos"),
    Leccion("Vitaminas y minerales", "Su importancia en la dieta"),
  ]);

  var usuario = Usuario("Laura");

  // Inscribirse
  usuario.inscribirse(curso1);
  usuario.inscribirse(curso2);

  // Completar lecciones
  usuario.completarLeccion(curso1, 0);
  usuario.completarLeccion(curso1, 1);

  // Ver progreso
  usuario.verProgreso(curso1);

  // Calificar cursos
  usuario.calificarCurso(curso1, 5);
  usuario.calificarCurso(curso2, 4);

  // Mostrar estadísticas
  usuario.mostrarEstadisticas();

  // Recomendaciones
  usuario.recomendarCursos([curso1, curso2, curso3]);
}
