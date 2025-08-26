import 'dart:io';

// Clase Resena (sin acentos en el identificador)
class Resena {
  Usuario autor;
  String comentario;
  int calificacion; // 1-5
  DateTime fecha;

  Resena(this.autor, this.comentario, this.calificacion)
    : fecha = DateTime.now();

  void mostrar() {
    print(
      "${autor.nombre} (${calificacion}): $comentario - ${fecha.toLocal()}",
    );
  }
}

// Clase Intercambio
class Intercambio {
  Usuario solicitante;
  Usuario duenio;
  Libro libro;
  bool completado = false;
  Resena? resena;

  Intercambio(this.solicitante, this.duenio, this.libro);

  void completar() {
    completado = true;
    print(
      "Intercambio completado: ${solicitante.nombre} recibió '${libro.titulo}' de ${duenio.nombre}",
    );
  }

  void agregarResena(Resena r) {
    resena = r;
    duenio.reputacion += r.calificacion;
    duenio.resenas.add(r);
  }
}

// Clase Libro
class Libro {
  String titulo;
  String autor;
  String categoria;
  Usuario propietario;

  Libro(this.titulo, this.autor, this.categoria, this.propietario);

  void mostrar() {
    print("'$titulo' de $autor [${categoria}] - Dueño: ${propietario.nombre}");
  }
}

// Clase Usuario
class Usuario {
  String nombre;
  List<Libro> librosDisponibles = [];
  List<Intercambio> historial = [];
  List<Resena> resenas = [];
  int reputacion = 0;
  List<String> notificaciones = [];

  Usuario(this.nombre);

  void publicarLibro(Libro libro) {
    librosDisponibles.add(libro);
    print("$nombre publicó el libro '${libro.titulo}'");
  }

  void solicitarIntercambio(Libro libro) {
    if (libro.propietario == this) {
      print("No puedes solicitar tu propio libro.");
      return;
    }
    var intercambio = Intercambio(this, libro.propietario, libro);
    historial.add(intercambio);
    libro.propietario.historial.add(intercambio);
    libro.propietario.notificaciones.add(
      "El usuario $nombre quiere intercambiar el libro '${libro.titulo}'",
    );
    print("$nombre solicitó '${libro.titulo}' a ${libro.propietario.nombre}");
  }

  void calificarIntercambio(
    Intercambio intercambio,
    int estrellas,
    String comentario,
  ) {
    if (!historial.contains(intercambio)) {
      print("No puedes calificar un intercambio en el que no participaste.");
      return;
    }
    var res = Resena(this, comentario, estrellas);
    intercambio.agregarResena(res);
    print("$nombre calificó el intercambio con ${intercambio.duenio.nombre}");
  }

  void mostrarHistorial() {
    print("\nHistorial de intercambios de $nombre:");
    if (historial.isEmpty) {
      print("No hay intercambios.");
    } else {
      for (var i in historial) {
        print(
          "- Libro: ${i.libro.titulo}, Dueño: ${i.duenio.nombre}, Estado: ${i.completado ? "Completado" : "Pendiente"}",
        );
        if (i.resena != null) i.resena!.mostrar();
      }
    }
  }

  void mostrarResenas() {
    print("\nReseñas de $nombre (Reputación: $reputacion):");
    if (resenas.isEmpty) {
      print("No tiene reseñas aún.");
    } else {
      for (var r in resenas) {
        r.mostrar();
      }
    }
  }

  void mostrarNotificaciones() {
    print("\nNotificaciones de $nombre:");
    if (notificaciones.isEmpty) {
      print("No tienes nuevas notificaciones.");
    } else {
      for (var n in notificaciones) {
        print("- $n");
      }
      notificaciones.clear(); // Se borran al leer
    }
  }
}

// Funciones de búsqueda
class Busqueda {
  static void buscarPorTitulo(List<Libro> libros, String titulo) {
    print("\nResultados de búsqueda por título '$titulo':");
    var encontrados = libros.where(
      (libro) => libro.titulo.toLowerCase().contains(titulo.toLowerCase()),
    );
    if (encontrados.isEmpty) {
      print("No se encontraron libros.");
    } else {
      for (var l in encontrados) {
        l.mostrar();
      }
    }
  }

  static void buscarPorCategoria(List<Libro> libros, String categoria) {
    print("\nResultados de búsqueda en categoría '$categoria':");
    var encontrados = libros.where(
      (libro) => libro.categoria.toLowerCase() == categoria.toLowerCase(),
    );
    if (encontrados.isEmpty) {
      print("No se encontraron libros.");
    } else {
      for (var l in encontrados) {
        l.mostrar();
      }
    }
  }
}

void main() {
  // Crear usuarios
  var ana = Usuario("Ana");
  var juan = Usuario("Juan");
  var laura = Usuario("Laura");

  // Publicar libros
  var libro1 = Libro(
    "Cien años de soledad",
    "Gabriel García Márquez",
    "Novela",
    ana,
  );
  var libro2 = Libro(
    "El principito",
    "Antoine de Saint-Exupéry",
    "Infantil",
    juan,
  );
  var libro3 = Libro("Clean Code", "Robert C. Martin", "Programación", laura);

  ana.publicarLibro(libro1);
  juan.publicarLibro(libro2);
  laura.publicarLibro(libro3);

  // Solicitar intercambios
  juan.solicitarIntercambio(libro1); // Juan pide libro de Ana
  ana.solicitarIntercambio(libro2); // Ana pide libro de Juan

  // Completar intercambio y calificar
  var intercambio1 = juan.historial.first;
  intercambio1.completar();
  juan.calificarIntercambio(
    intercambio1,
    5,
    "Muy buen trato, libro en excelente estado.",
  );

  // Revisar reseñas y reputación
  ana.mostrarResenas();

  // Notificaciones
  ana.mostrarNotificaciones();
  juan.mostrarNotificaciones();

  // Búsquedas
  var todosLosLibros = [libro1, libro2, libro3];
  Busqueda.buscarPorTitulo(todosLosLibros, "Clean");
  Busqueda.buscarPorCategoria(todosLosLibros, "Novela");

  // Historial
  juan.mostrarHistorial();
}
