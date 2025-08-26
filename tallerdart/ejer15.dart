// ejer15_inventario.dart
// Sistema simple de gestión de inventario
import 'dart:io';

class Movimiento {
  DateTime fecha;
  String tipo; // "entrada" o "salida"
  int cantidad;
  String nota;

  Movimiento(this.tipo, this.cantidad, this.nota) : fecha = DateTime.now();

  @override
  String toString() =>
      "${fecha.toLocal()} - ${tipo.toUpperCase()}: $cantidad (${nota})";
}

class Producto {
  String id;
  String nombre;
  String categoria;
  double precioUnitario;
  int stock;
  int stockMinimo;
  String proveedorId; // proveedor preferido
  List<Movimiento> historial = [];

  Producto(
    this.id,
    this.nombre,
    this.categoria,
    this.precioUnitario,
    this.stock,
    this.stockMinimo,
    this.proveedorId,
  );

  void registrarMovimiento(String tipo, int cantidad, String nota) {
    if (tipo == "salida" && cantidad > stock) {
      throw Exception("No hay stock suficiente para $nombre.");
    }
    if (tipo == "salida") stock -= cantidad;
    if (tipo == "entrada") stock += cantidad;
    historial.add(Movimiento(tipo, cantidad, nota));
  }

  bool necesitaReposicion() => stock <= stockMinimo;

  @override
  String toString() =>
      "[$id] $nombre | Cat: $categoria | Stock: $stock | Precio: \$${precioUnitario.toStringAsFixed(2)} | Min: $stockMinimo | Prov: $proveedorId";
}

class Proveedor {
  String id;
  String nombre;
  String contacto;

  Proveedor(this.id, this.nombre, this.contacto);

  @override
  String toString() => "$id - $nombre (Contacto: $contacto)";
}

class OrdenCompra {
  String id;
  String proveedorId;
  Map<String, int> items; // productId -> cantidad
  DateTime fechaCreacion;
  bool recibida = false;

  OrdenCompra(this.id, this.proveedorId, this.items)
    : fechaCreacion = DateTime.now();

  @override
  String toString() =>
      "Orden $id | Proveedor: $proveedorId | Items: ${items.length} | Fecha: ${fechaCreacion.toLocal()} | Recibida: $recibida";
}

class Inventario {
  final Map<String, Producto> _productos = {};
  final Map<String, Proveedor> _proveedores = {};
  final Map<String, OrdenCompra> _ordenes = {};
  int _idCounter = 1;

  String _nextId(String prefix) =>
      "$prefix${(_idCounter++).toString().padLeft(4, '0')}";

  // Proveedores
  void agregarProveedor(String nombre, String contacto) {
    var id = _nextId("PRV");
    _proveedores[id] = Proveedor(id, nombre, contacto);
    print("Proveedor agregado: ${_proveedores[id]}");
  }

  void listarProveedores() {
    if (_proveedores.isEmpty) {
      print("No hay proveedores registrados.");
      return;
    }
    print("\n--- Proveedores ---");
    _proveedores.values.forEach((p) => print(p));
  }

  // Productos
  void agregarProducto(
    String nombre,
    String categoria,
    double precio,
    int stock,
    int stockMinimo,
    String proveedorId,
  ) {
    if (!_proveedores.containsKey(proveedorId)) {
      print("Proveedor $proveedorId no existe. Crea el proveedor primero.");
      return;
    }
    var id = _nextId("PRD");
    _productos[id] = Producto(
      id,
      nombre,
      categoria,
      precio,
      stock,
      stockMinimo,
      proveedorId,
    );
    print("Producto agregado: ${_productos[id]}");
  }

  void listarProductos() {
    if (_productos.isEmpty) {
      print("No hay productos en el inventario.");
      return;
    }
    print("\n--- Productos en Inventario ---");
    _productos.values.forEach((p) => print(p));
  }

  Producto? buscarProductoPorId(String id) => _productos[id];

  List<Producto> buscarPorCategoria(String categoria) => _productos.values
      .where((p) => p.categoria.toLowerCase() == categoria.toLowerCase())
      .toList();

  // Operaciones de stock
  void registrarSalida(String productId, int cantidad, String nota) {
    var p = buscarProductoPorId(productId);
    if (p == null) {
      print("Producto $productId no encontrado.");
      return;
    }
    try {
      p.registrarMovimiento("salida", cantidad, nota);
      print("Salida registrada: $cantidad x ${p.nombre}");
      if (p.necesitaReposicion()) {
        print(
          "ALERTA: ${p.nombre} necesita reposición (stock ${p.stock} <= min ${p.stockMinimo}).",
        );
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  void registrarEntrada(String productId, int cantidad, String nota) {
    var p = buscarProductoPorId(productId);
    if (p == null) {
      print("Producto $productId no encontrado.");
      return;
    }
    p.registrarMovimiento("entrada", cantidad, nota);
    print("Entrada registrada: $cantidad x ${p.nombre}");
  }

  // Historial
  void mostrarHistorialProducto(String productId) {
    var p = buscarProductoPorId(productId);
    if (p == null) {
      print("Producto $productId no encontrado.");
      return;
    }
    print("\nHistorial de ${p.nombre}:");
    if (p.historial.isEmpty) {
      print("No hay movimientos.");
    } else {
      p.historial.forEach((m) => print(m));
    }
  }

  // Valor del inventario
  double valorInventario() {
    double total = 0;
    _productos.values.forEach((p) => total += p.stock * p.precioUnitario);
    return total;
  }

  // Ordenes de compra automáticas (por proveedor)
  void generarOrdenesReposicion() {
    // agrupar por proveedor las necesidades
    Map<String, Map<String, int>> porProveedor =
        {}; // provId -> (prodId->cantidad)
    _productos.forEach((id, p) {
      if (p.necesitaReposicion()) {
        int pedir = (p.stockMinimo * 2) - p.stock; // regla simple: dejar 2x min
        if (pedir <= 0) pedir = p.stockMinimo;
        porProveedor.putIfAbsent(p.proveedorId, () => {});
        porProveedor[p.proveedorId]![id] = pedir;
      }
    });

    if (porProveedor.isEmpty) {
      print("No hay productos que requieran reposición.");
      return;
    }

    porProveedor.forEach((provId, items) {
      var idOrden = _nextId("ORD");
      var orden = OrdenCompra(idOrden, provId, items);
      _ordenes[idOrden] = orden;
      print(
        "Orden generada: $idOrden para proveedor $provId con ${items.length} ítems.",
      );
    });
  }

  void listarOrdenesPendientes() {
    print("\n--- Órdenes pendientes ---");
    var pendientes = _ordenes.values.where((o) => !o.recibida).toList();
    if (pendientes.isEmpty) {
      print("No hay órdenes pendientes.");
      return;
    }
    for (var o in pendientes) {
      print(o);
      o.items.forEach((prodId, qty) {
        var prod = buscarProductoPorId(prodId);
        print("   - ${prod?.nombre ?? prodId}: $qty unidades");
      });
    }
  }

  // Recibir orden: aumentar stock
  void recibirOrden(String ordenId) {
    var orden = _ordenes[ordenId];
    if (orden == null) {
      print("Orden $ordenId no encontrada.");
      return;
    }
    if (orden.recibida) {
      print("Orden $ordenId ya ha sido recibida.");
      return;
    }
    orden.items.forEach((prodId, qty) {
      var prod = buscarProductoPorId(prodId);
      if (prod != null) {
        prod.registrarMovimiento("entrada", qty, "Recepción orden $ordenId");
      } else {
        print("Producto $prodId de la orden no existe en inventario.");
      }
    });
    orden.recibida = true;
    print("Orden $ordenId marcada como recibida y stock actualizado.");
  }

  // Reportes resumidos
  void reporteResumen() {
    print("\n=== REPORTE RESUMEN ===");
    print("Productos totales: ${_productos.length}");
    print("Valor total inventario: \$${valorInventario().toStringAsFixed(2)}");
    var bajos = _productos.values.where((p) => p.necesitaReposicion()).toList();
    print("Productos por debajo del mínimo: ${bajos.length}");
    if (bajos.isNotEmpty) {
      bajos.forEach(
        (p) => print(
          " - ${p.id} ${p.nombre} Stock: ${p.stock} Min: ${p.stockMinimo}",
        ),
      );
    }
  }

  // Buscar por nombre parcial
  List<Producto> buscarPorNombre(String fragmento) {
    var f = fragmento.toLowerCase();
    return _productos.values
        .where((p) => p.nombre.toLowerCase().contains(f))
        .toList();
  }
}

void main() {
  var inv = Inventario();

  // Crear proveedores
  inv.agregarProveedor("Distribuidora Alfa", "contacto@alfa.com");
  inv.agregarProveedor("Servicios Beta", "ventas@beta.com");
  inv.listarProveedores();

  // Agregar productos (usando ids de proveedores mostrados)
  // Supón que los proveedores generados fueron PRV0001 y PRV0002
  inv.agregarProducto("Cinta adhesiva", "Papelería", 1.50, 20, 10, "PRV0001");
  inv.agregarProducto("Toner impresora", "Oficina", 80.0, 3, 5, "PRV0002");
  inv.agregarProducto("Papel A4", "Papelería", 4.5, 50, 20, "PRV0001");

  inv.listarProductos();

  // Registrar algunas salidas (ventas/consumo)
  inv.registrarSalida("PRD0001", 5, "Venta online #1001");
  inv.registrarSalida("PRD0002", 1, "Reemplazo cliente X");

  // Mostrar historial de un producto
  inv.mostrarHistorialProducto("PRD0001");

  // Generar órdenes de reposición (productos con stock <= min)
  inv.generarOrdenesReposicion();
  inv.listarOrdenesPendientes();

  // Recibir una orden (usa la primera orden generada)
  var primeraOrdenId = inv._ordenes.keys.isEmpty
      ? null
      : inv._ordenes.keys.first;
  if (primeraOrdenId != null) {
    inv.recibirOrden(primeraOrdenId);
  }

  // Reportes
  inv.reporteResumen();

  // Buscar por categoría o nombre
  var papeleria = inv.buscarPorCategoria("Papelería");
  print("\nProductos categoría 'Papelería':");
  papeleria.forEach((p) => print(" - ${p.id} ${p.nombre} Stock: ${p.stock}"));

  var busq = inv.buscarPorNombre("papel");
  print("\nBúsqueda por nombre 'papel':");
  busq.forEach((p) => print(" - ${p.id} ${p.nombre}"));

  // Valor inventario
  print(
    "\nValor total de inventario: \$${inv.valorInventario().toStringAsFixed(2)}",
  );

  // Fin
  print("\nSimulación finalizada.");
}
