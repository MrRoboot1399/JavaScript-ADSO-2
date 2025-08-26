// ejer13_finanzas.dart
// Ejercicio 13: Aplicación de Finanzas Personales (versión didáctica y funcional)

import 'dart:math';

enum TipoTransaccion { ingreso, gasto }

// Clase Categoria (simple)
class Categoria {
  String nombre;
  List<String> palabrasClave; // para categorización automática

  Categoria(this.nombre, [List<String>? palabrasClave])
    : palabrasClave = palabrasClave ?? [];
}

// Clase Transaccion
class Transaccion {
  String descripcion;
  double monto;
  DateTime fecha;
  TipoTransaccion tipo;
  Categoria? categoria;
  String cuentaId;

  Transaccion({
    required this.descripcion,
    required this.monto,
    required this.fecha,
    required this.tipo,
    required this.cuentaId,
    this.categoria,
  });

  @override
  String toString() {
    String t = tipo == TipoTransaccion.ingreso ? "Ingreso" : "Gasto";
    String cat = categoria?.nombre ?? "Sin categoria";
    return "$t | ${fecha.toIso8601String().split('T').first} | \$${monto.toStringAsFixed(2)} | $descripcion | $cat | Cuenta: $cuentaId";
  }
}

// Clase Cuenta
class Cuenta {
  String id;
  String nombre;
  double saldo;

  Cuenta(this.id, this.nombre, [this.saldo = 0]);

  void aplicar(double monto) {
    saldo += monto;
  }
}

// Clase Presupuesto mensual por categoría
class Presupuesto {
  int year;
  int month; // 1..12
  Map<String, double> topePorCategoria; // nombreCategoria -> tope mensual

  Presupuesto(this.year, this.month) : topePorCategoria = {};

  void setTope(String categoria, double amount) {
    topePorCategoria[categoria] = amount;
  }

  double obtenerTope(String categoria) {
    return topePorCategoria[categoria] ?? 0;
  }
}

// Clase Meta de ahorro
class MetaAhorro {
  String nombre;
  double objetivo;
  double alcanzado;
  DateTime fechaLimite;

  MetaAhorro(this.nombre, this.objetivo, this.fechaLimite) : alcanzado = 0;

  bool cumplida() => alcanzado >= objetivo;

  double restante() => max(0, objetivo - alcanzado);
}

// Usuario (maneja cuentas, transacciones, categorías, presupuestos, metas)
class Usuario {
  String nombre;
  Map<String, Cuenta> cuentas = {}; // id -> Cuenta
  List<Transaccion> transacciones = [];
  List<Categoria> categorias = [];
  List<Presupuesto> presupuestos = [];
  List<MetaAhorro> metas = [];

  Usuario(this.nombre);

  // Cuentas
  void agregarCuenta(String id, String nombre, [double saldoInicial = 0]) {
    if (cuentas.containsKey(id)) {
      print("La cuenta con id '$id' ya existe.");
      return;
    }
    cuentas[id] = Cuenta(id, nombre, saldoInicial);
    print(
      "Cuenta '$nombre' agregada con id '$id' y saldo inicial \$${saldoInicial.toStringAsFixed(2)}.",
    );
  }

  // Categorías (base para categorización automática)
  void agregarCategoria(Categoria c) {
    categorias.add(c);
  }

  // Presupuestos
  void setPresupuesto(int year, int month, String categoria, double tope) {
    var p = presupuestos.firstWhere(
      (x) => x.year == year && x.month == month,
      orElse: () {
        var newP = Presupuesto(year, month);
        presupuestos.add(newP);
        return newP;
      },
    );
    p.setTope(categoria, tope);
    print(
      "Presupuesto: ${year}-${month.toString().padLeft(2, '0')} -> $categoria: \$${tope.toStringAsFixed(2)}",
    );
  }

  // Metas de ahorro
  void crearMeta(String nombre, double objetivo, DateTime fechaLimite) {
    metas.add(MetaAhorro(nombre, objetivo, fechaLimite));
    print(
      "Meta creada: $nombre -> objetivo \$${objetivo.toStringAsFixed(2)} hasta ${fechaLimite.toLocal()}",
    );
  }

  // Agregar transacción (y categorizar automáticamente)
  void agregarTransaccion(Transaccion t) {
    if (!cuentas.containsKey(t.cuentaId)) {
      print("Cuenta '${t.cuentaId}' no encontrada. Transacción cancelada.");
      return;
    }

    // Categorizar automáticamente si no tiene categoría
    if (t.categoria == null) {
      t.categoria = _categorizar(t.descripcion);
    }

    // Aplicar a la cuenta
    double delta = t.tipo == TipoTransaccion.ingreso ? t.monto : -t.monto;
    cuentas[t.cuentaId]!.aplicar(delta);

    transacciones.add(t);

    // Si es gasto, actualizar metas (asimilando transferencia a ahorro si descripción coincide por palabra 'ahorro')
    if (t.tipo == TipoTransaccion.gasto) {
      _actualizarMetasConGasto(t);
    }

    print("Transacción agregada: ${t.toString()}");
    // Post-check: alerta sobregiro
    if (cuentas[t.cuentaId]!.saldo < 0) {
      print(
        "ALERTA: La cuenta '${cuentas[t.cuentaId]!.nombre}' queda en sobregiro (\$${cuentas[t.cuentaId]!.saldo.toStringAsFixed(2)}).",
      );
    }
  }

  // Categoría automática simple: busca palabra clave en descripción
  Categoria? _categorizar(String descripcion) {
    String desc = descripcion.toLowerCase();
    for (var c in categorias) {
      for (var k in c.palabrasClave) {
        if (desc.contains(k.toLowerCase())) {
          return c;
        }
      }
    }
    return null; // sin categoría si no encontró
  }

  // Actualizar metas si la transacción representa aporte a meta (heurística simple)
  void _actualizarMetasConGasto(Transaccion t) {
    // Si la descripción contiene 'ahorro' o 'meta' o 'transferencia a ahorro' actualizar primera meta abierta
    String desc = t.descripcion.toLowerCase();
    if (desc.contains("ahorro") ||
        desc.contains("meta") ||
        desc.contains("transferencia")) {
      if (metas.isNotEmpty) {
        var meta = metas.firstWhere(
          (m) => !m.cumplida(),
          orElse: () => metas.last,
        );
        // considerar monto como aporte positivo a la meta (gasto que representa ahorro)
        meta.alcanzado += t.monto;
        print(
          "Meta '${meta.nombre}' actualizada: alcanzado \$${meta.alcanzado.toStringAsFixed(2)} / \$${meta.objetivo.toStringAsFixed(2)}",
        );
      }
    }
  }

  // Reportes
  // 1) Reporte mensual por categoría
  Map<String, double> reporteGastosPorCategoria(int year, int month) {
    Map<String, double> resumen = {};
    for (var t in transacciones) {
      if (t.tipo == TipoTransaccion.gasto &&
          t.fecha.year == year &&
          t.fecha.month == month) {
        String cat = t.categoria?.nombre ?? "Sin categoria";
        resumen[cat] = (resumen[cat] ?? 0) + t.monto;
      }
    }
    return resumen;
  }

  // 2) Totales por cuenta
  Map<String, double> saldoPorCuenta() {
    return {for (var e in cuentas.entries) e.key: e.value.saldo};
  }

  // 3) Gasto total en el mes
  double gastoTotalMes(int year, int month) {
    double total = 0;
    for (var t in transacciones) {
      if (t.tipo == TipoTransaccion.gasto &&
          t.fecha.year == year &&
          t.fecha.month == month) {
        total += t.monto;
      }
    }
    return total;
  }

  // 4) Comprobar presupuestos y generar alertas
  void verificarPresupuestos(int year, int month) {
    var resumen = reporteGastosPorCategoria(year, month);
    for (var p in presupuestos.where(
      (p) => p.year == year && p.month == month,
    )) {
      for (var catEntry in p.topePorCategoria.entries) {
        String cat = catEntry.key;
        double tope = catEntry.value;
        double gastado = resumen[cat] ?? 0;
        if (gastado >= tope) {
          print(
            "ALERTA: Has alcanzado o excedido el presupuesto para '$cat' (\$${gastado.toStringAsFixed(2)} / \$${tope.toStringAsFixed(2)})",
          );
        } else if (gastado >= 0.8 * tope) {
          print(
            "Aviso: Estás cerca del tope para '$cat' (\$${gastado.toStringAsFixed(2)} / \$${tope.toStringAsFixed(2)})",
          );
        }
      }
    }
  }

  // 5) Estadísticas: porcentaje por categoría en mes y promedio mensual por categoría (sobre todo histórico simple)
  Map<String, double> porcentajePorCategoria(int year, int month) {
    double total = gastoTotalMes(year, month);
    Map<String, double> porc = {};
    if (total == 0) return porc;
    var resumen = reporteGastosPorCategoria(year, month);
    resumen.forEach((cat, val) {
      porc[cat] = (val / total) * 100;
    });
    return porc;
  }

  // 6) Análisis de patrones simple: categorías con mayor gasto en últimos N meses
  Map<String, double> gastoEnRango(DateTime desde, DateTime hasta) {
    Map<String, double> resumen = {};
    for (var t in transacciones) {
      if (t.tipo == TipoTransaccion.gasto &&
          !t.fecha.isBefore(desde) &&
          !t.fecha.isAfter(hasta)) {
        String cat = t.categoria?.nombre ?? "Sin categoria";
        resumen[cat] = (resumen[cat] ?? 0) + t.monto;
      }
    }
    return resumen;
  }

  // Utilidades para mostrar reportes
  void imprimirReporteMensual(int year, int month) {
    print("\nREPORTE MES: $year-${month.toString().padLeft(2, '0')}");
    var resumen = reporteGastosPorCategoria(year, month);
    if (resumen.isEmpty) {
      print("No hay gastos registrados en ese mes.");
    } else {
      resumen.forEach((cat, val) {
        print("- $cat: \$${val.toStringAsFixed(2)}");
      });
      print("Gasto total: \$${gastoTotalMes(year, month).toStringAsFixed(2)}");
      var porcentajes = porcentajePorCategoria(year, month);
      if (porcentajes.isNotEmpty) {
        print("Porcentaje por categoría:");
        porcentajes.forEach((cat, p) {
          print("  $cat: ${p.toStringAsFixed(1)}%");
        });
      }
    }
  }

  void imprimirSaldos() {
    print("\nSaldos por cuenta:");
    saldoPorCuenta().forEach((id, s) {
      print("- $id (${cuentas[id]!.nombre}): \$${s.toStringAsFixed(2)}");
    });
  }

  void imprimirMetas() {
    print("\nMetas de ahorro:");
    if (metas.isEmpty) {
      print("No tienes metas definidas.");
    } else {
      for (var m in metas) {
        print(
          "- ${m.nombre}: objetivo \$${m.objetivo.toStringAsFixed(2)}, alcanzado \$${m.alcanzado.toStringAsFixed(2)}, restante \$${m.restante().toStringAsFixed(2)} (limite ${m.fechaLimite.toLocal()}) ${m.cumplida() ? '[CUMPLIDA]' : ''}",
        );
      }
    }
  }
}

// Ejemplo de uso en main
void main() {
  var user = Usuario("Carlos");

  // Crear categorías con palabras clave para autocat
  user.agregarCategoria(
    Categoria("Alimentación", ["restaurante", "comida", "super", "mercado"]),
  );
  user.agregarCategoria(
    Categoria("Transporte", ["taxi", "uber", "bus", "gasolina", "gas"]),
  );
  user.agregarCategoria(
    Categoria("Entretenimiento", ["cine", "netflix", "spotify", "concierto"]),
  );
  user.agregarCategoria(
    Categoria("Servicios", ["luz", "agua", "internet", "telefono"]),
  );
  user.agregarCategoria(
    Categoria("Ahorro", ["ahorro", "meta", "transferencia a ahorro"]),
  );

  // Agregar cuentas
  user.agregarCuenta("c1", "Cuenta corriente", 500.0);
  user.agregarCuenta(
    "c2",
    "Tarjeta de crédito",
    -100.0,
  ); // saldo negativo simulado
  user.agregarCuenta("c3", "Cuenta de ahorros", 1000.0);

  // Crear presupuestos
  var hoy = DateTime.now();
  user.setPresupuesto(hoy.year, hoy.month, "Alimentación", 200.0);
  user.setPresupuesto(hoy.year, hoy.month, "Transporte", 100.0);

  // Crear metas
  user.crearMeta(
    "Viaje a Cartagena",
    800.0,
    DateTime(hoy.year, hoy.month + 6, 1),
  );

  // Agregar transacciones (algunas con palabras clave para categorización)
  user.agregarTransaccion(
    Transaccion(
      descripcion: "Compra en super 'La Plaza'",
      monto: 45.30,
      fecha: hoy.subtract(Duration(days: 2)),
      tipo: TipoTransaccion.gasto,
      cuentaId: "c1",
    ),
  );

  user.agregarTransaccion(
    Transaccion(
      descripcion: "Gasolina estación El Sol",
      monto: 60.0,
      fecha: hoy.subtract(Duration(days: 1)),
      tipo: TipoTransaccion.gasto,
      cuentaId: "c1",
    ),
  );

  user.agregarTransaccion(
    Transaccion(
      descripcion: "Pago sueldo",
      monto: 1500.0,
      fecha: hoy.subtract(Duration(days: 10)),
      tipo: TipoTransaccion.ingreso,
      cuentaId: "c1",
    ),
  );

  user.agregarTransaccion(
    Transaccion(
      descripcion: "Transferencia a ahorro (ahorro mensual)",
      monto: 100.0,
      fecha: todayPlusDays(0),
      tipo: TipoTransaccion.gasto,
      cuentaId: "c1",
    ),
  );

  user.agregarTransaccion(
    Transaccion(
      descripcion: "Netflix suscripción",
      monto: 12.99,
      fecha: todayPlusDays(0),
      tipo: TipoTransaccion.gasto,
      cuentaId: "c2",
    ),
  );

  // Mostrar saldos
  user.imprimirSaldos();

  // Reporte mensual
  user.imprimirReporteMensual(hoy.year, hoy.month);

  // Verificar presupuestos
  user.verificarPresupuestos(hoy.year, hoy.month);

  // Analizar patrón: gastos últimos 30 días
  var desde = hoy.subtract(Duration(days: 30));
  var resumenRange = user.gastoEnRango(desde, hoy);
  print("\nGastos últimos 30 días por categoría:");
  resumenRange.forEach((k, v) => print("- $k: \$${v.toStringAsFixed(2)}"));

  // Imprimir metas
  user.imprimirMetas();
}

// pequeña utilidad para crear fechas 'hoy' consistente
DateTime todayPlusDays(int days) => DateTime.now().add(Duration(days: days));
