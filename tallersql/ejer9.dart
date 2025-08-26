import 'dart:io';

// Clase Archivo
class Archivo {
  String nombre;
  double tamano; // en MB
  String tipo; // imagen, video, documento, etc.
  DateTime fechaCreacion;
  String ruta;

  Archivo(this.nombre, this.tamano, this.tipo, this.ruta)
    : fechaCreacion = DateTime.now();

  void mostrar() {
    print(
      "$nombre ($tipo) - ${tamano}MB | Creado: ${fechaCreacion.toLocal()} | Ruta: $ruta",
    );
  }
}

// Clase GestorArchivos
class GestorArchivos {
  List<Archivo> archivos = [];

  void agregar(Archivo a) {
    archivos.add(a);
    print("Archivo '${a.nombre}' agregado en la ruta ${a.ruta}.");
  }

  void listar() {
    print("\n=== LISTA DE ARCHIVOS ===");
    if (archivos.isEmpty) {
      print("No hay archivos almacenados.");
    } else {
      for (var a in archivos) {
        a.mostrar();
      }
    }
  }

  void buscarPorNombre(String nombre) {
    print("\n=== RESULTADOS DE BÚSQUEDA: $nombre ===");
    var encontrados = archivos.where((a) => a.nombre.contains(nombre));
    if (encontrados.isEmpty) {
      print("No se encontraron archivos con ese nombre.");
    } else {
      for (var a in encontrados) {
        a.mostrar();
      }
    }
  }

  void buscarPorTipo(String tipo) {
    print("\n=== ARCHIVOS DE TIPO: $tipo ===");
    var encontrados = archivos.where((a) => a.tipo == tipo);
    if (encontrados.isEmpty) {
      print("No hay archivos de este tipo.");
    } else {
      for (var a in encontrados) {
        a.mostrar();
      }
    }
  }

  void calcularEspacioUsado() {
    double total = archivos.fold(0, (suma, a) => suma + a.tamano);
    print("\nEspacio total usado: ${total.toStringAsFixed(2)} MB");
  }

  void organizarPorFecha() {
    print("\n=== ARCHIVOS ORDENADOS POR FECHA ===");
    var ordenados = [...archivos]
      ..sort((a, b) => a.fechaCreacion.compareTo(b.fechaCreacion));
    for (var a in ordenados) {
      a.mostrar();
    }
  }

  void organizarPorTamano() {
    print("\n=== ARCHIVOS ORDENADOS POR TAMAÑO ===");
    var ordenados = [...archivos]..sort((a, b) => a.tamano.compareTo(b.tamano));
    for (var a in ordenados) {
      a.mostrar();
    }
  }

  void transferir(String nombreArchivo, String nuevaRuta) {
    for (var a in archivos) {
      if (a.nombre == nombreArchivo) {
        print(
          "\nTransfiriendo archivo '${a.nombre}' de '${a.ruta}' a '$nuevaRuta'...",
        );
        a.ruta = nuevaRuta;
        print("Transferencia completada.");
        return;
      }
    }
    print("Archivo '$nombreArchivo' no encontrado.");
  }
}

void main() {
  GestorArchivos gestor = GestorArchivos();

  // Agregar archivos
  gestor.agregar(Archivo("foto1.jpg", 2.5, "imagen", "/imagenes"));
  gestor.agregar(Archivo("documento1.pdf", 1.2, "documento", "/documentos"));
  gestor.agregar(Archivo("video1.mp4", 50.0, "video", "/videos"));
  gestor.agregar(Archivo("cancion.mp3", 3.5, "audio", "/musica"));

  // Listar archivos
  gestor.listar();

  // Buscar por nombre
  gestor.buscarPorNombre("foto");

  // Buscar por tipo
  gestor.buscarPorTipo("video");

  // Calcular espacio usado
  gestor.calcularEspacioUsado();

  // Organizar por fecha
  gestor.organizarPorFecha();

  // Organizar por tamaño
  gestor.organizarPorTamano();

  // Simular transferencia
  gestor.transferir("foto1.jpg", "/backup/imagenes");

  // Listar después de transferencia
  gestor.listar();
}
