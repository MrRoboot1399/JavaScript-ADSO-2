import 'dart:math';

// Clase que representa una ubicación GPS
class Ubicacion {
  String nombre;
  double latitud;
  double longitud;
  String categoria; // casa, trabajo, restaurante, hospital
  String notas;

  Ubicacion(
    this.nombre,
    this.latitud,
    this.longitud,
    this.categoria,
    this.notas,
  );

  void mostrar() {
    print("📍 $nombre [$categoria]");
    print("   Lat: $latitud, Long: $longitud");
    print("   Notas: $notas\n");
  }
}

// Clase para gestionar ubicaciones favoritas
class GestorUbicaciones {
  List<Ubicacion> ubicaciones = [];

  void agregar(Ubicacion u) {
    ubicaciones.add(u);
    print("✅ Ubicación '${u.nombre}' agregada.");
  }

  void eliminar(String nombre) {
    ubicaciones.removeWhere((u) => u.nombre == nombre);
    print("🗑️ Ubicación '$nombre' eliminada.");
  }

  void buscarPorCategoria(String categoria) {
    print("\n🔎 Ubicaciones en categoría: $categoria");
    var filtradas = ubicaciones.where((u) => u.categoria == categoria);
    if (filtradas.isEmpty) {
      print("No hay ubicaciones de esa categoría.\n");
    } else {
      for (var u in filtradas) {
        u.mostrar();
      }
    }
  }

  // Distancia aproximada usando fórmula de Haversine
  double calcularDistancia(Ubicacion a, Ubicacion b) {
    const R = 6371; // radio de la Tierra en km
    double dLat = _gradosARadianes(b.latitud - a.latitud);
    double dLon = _gradosARadianes(b.longitud - a.longitud);

    double lat1 = _gradosARadianes(a.latitud);
    double lat2 = _gradosARadianes(b.latitud);

    double h =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double distancia = 2 * R * atan2(sqrt(h), sqrt(1 - h));
    return distancia;
  }

  double _gradosARadianes(double grados) {
    return grados * pi / 180;
  }

  void mostrarTodas() {
    print("\n=== UBICACIONES FAVORITAS ===");
    for (var u in ubicaciones) {
      u.mostrar();
    }
  }
}

void main() {
  GestorUbicaciones gestor = GestorUbicaciones();

  // Agregar ubicaciones
  gestor.agregar(
    Ubicacion("Casa", 6.2518, -75.5636, "casa", "Mi hogar en Medellín"),
  );
  gestor.agregar(
    Ubicacion("Trabajo", 6.2442, -75.5812, "trabajo", "Oficina centro"),
  );
  gestor.agregar(
    Ubicacion(
      "Restaurante",
      6.2600,
      -75.5700,
      "restaurante",
      "Pizzería favorita",
    ),
  );

  gestor.mostrarTodas();

  // Buscar por categoría
  gestor.buscarPorCategoria("restaurante");

  // Calcular distancia entre Casa y Trabajo
  double distancia = gestor.calcularDistancia(
    gestor.ubicaciones[0],
    gestor.ubicaciones[1],
  );
  print("📏 Distancia Casa - Trabajo: ${distancia.toStringAsFixed(2)} km\n");

  // Eliminar una ubicación
  gestor.eliminar("Trabajo");

  gestor.mostrarTodas();
}
