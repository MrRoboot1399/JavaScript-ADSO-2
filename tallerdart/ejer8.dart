import 'dart:math';

// Clase Canción
class Cancion {
  String titulo;
  String artista;
  double duracion; // en minutos
  String genero;
  int calificacion; // 1 a 5 estrellas

  Cancion(
    this.titulo,
    this.artista,
    this.duracion,
    this.genero,
    this.calificacion,
  );

  void mostrar() {
    print(
      "$titulo - $artista [$genero] (${duracion} min) Calificación: $calificacion",
    );
  }
}

// Clase Playlist
class Playlist {
  String nombre;
  List<Cancion> canciones = [];
  int reproducciones = 0;

  Playlist(this.nombre);

  void agregar(Cancion c) {
    canciones.add(c);
    print("Canción '${c.titulo}' agregada a la playlist '$nombre'.");
  }

  void eliminar(String titulo) {
    canciones.removeWhere((c) => c.titulo == titulo);
    print("Canción '$titulo' eliminada de la playlist.");
  }

  void mostrarTodas() {
    print("\n=== Playlist: $nombre ===");
    if (canciones.isEmpty) {
      print("La playlist está vacía.");
    } else {
      for (var c in canciones) {
        c.mostrar();
      }
    }
  }

  void reproducirAleatoria() {
    if (canciones.isEmpty) {
      print("No hay canciones para reproducir.");
      return;
    }
    Random random = Random();
    var cancion = canciones[random.nextInt(canciones.length)];
    reproducciones++;
    print("\nReproduciendo ahora:");
    cancion.mostrar();
  }

  void calcularDuracionTotal() {
    double total = canciones.fold(0, (suma, c) => suma + c.duracion);
    print("\nDuración total: ${total.toStringAsFixed(2)} min");
  }

  void filtrarPorGenero(String genero) {
    print("\nCanciones del género: $genero");
    var filtradas = canciones.where((c) => c.genero == genero);
    if (filtradas.isEmpty) {
      print("No hay canciones de este género.");
    } else {
      for (var c in filtradas) {
        c.mostrar();
      }
    }
  }

  void mostrarEstadisticas() {
    print("\nEstadísticas de la playlist '$nombre':");
    print("Total canciones: ${canciones.length}");
    print("Reproducciones: $reproducciones");

    if (canciones.isNotEmpty) {
      double promedio =
          canciones.fold(0, (suma, c) => suma + c.calificacion) /
          canciones.length;
      print("Calificación promedio: ${promedio.toStringAsFixed(1)}");
    }
  }
}

void main() {
  Playlist miPlaylist = Playlist("Favoritas");

  // Agregar canciones
  miPlaylist.agregar(Cancion("Shape of You", "Ed Sheeran", 4.2, "Pop", 5));
  miPlaylist.agregar(Cancion("Bohemian Rhapsody", "Queen", 6.0, "Rock", 5));
  miPlaylist.agregar(Cancion("Blinding Lights", "The Weeknd", 3.5, "Pop", 4));
  miPlaylist.agregar(
    Cancion("Smells Like Teen Spirit", "Nirvana", 5.0, "Rock", 5),
  );

  // Mostrar todas
  miPlaylist.mostrarTodas();

  // Reproducir aleatoria
  miPlaylist.reproducirAleatoria();

  // Calcular duración total
  miPlaylist.calcularDuracionTotal();

  // Filtrar por género
  miPlaylist.filtrarPorGenero("Pop");

  // Eliminar canción
  miPlaylist.eliminar("Blinding Lights");

  // Mostrar estadísticas
  miPlaylist.mostrarEstadisticas();
}
