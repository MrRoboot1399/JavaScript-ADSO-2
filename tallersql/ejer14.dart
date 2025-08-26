import 'dart:io';

class Organizador {
  String nombre;
  String contacto;

  Organizador(this.nombre, this.contacto);
}

class Participante {
  String nombre;
  String email;

  Participante(this.nombre, this.email);
}

class Evento {
  String titulo;
  String categoria;
  String ubicacion;
  Organizador organizador;
  List<Participante> participantes = [];

  Evento(this.titulo, this.categoria, this.ubicacion, this.organizador);

  void registrarParticipante(Participante p) {
    participantes.add(p);
    print("Participante ${p.nombre} registrado en $titulo");
  }

  void mostrarInfo() {
    print("\n=== EVENTO ===");
    print("Título: $titulo");
    print("Categoría: $categoria");
    print("Ubicación: $ubicacion");
    print("Organizador: ${organizador.nombre}");
    print("Total participantes: ${participantes.length}");
  }
}

class SistemaEventos {
  List<Evento> eventos = [];

  void crearEvento(Evento e) {
    eventos.add(e);
    print("Evento '${e.titulo}' creado.");
  }

  void mostrarEventos() {
    if (eventos.isEmpty) {
      print("No hay eventos registrados.");
    } else {
      print("\n=== LISTA DE EVENTOS ===");
      for (var e in eventos) {
        e.mostrarInfo();
      }
    }
  }
}

void main() {
  SistemaEventos sistema = SistemaEventos();

  // Crear un organizador
  Organizador org = Organizador("Carlos Pérez", "carlos@mail.com");

  // Crear un evento
  Evento ev = Evento("Feria de Tecnología", "Educación", "Parque Central", org);
  sistema.crearEvento(ev);

  // Registrar participantes
  ev.registrarParticipante(Participante("Ana", "ana@mail.com"));
  ev.registrarParticipante(Participante("Luis", "luis@mail.com"));

  // Mostrar info de eventos
  sistema.mostrarEventos();
}
