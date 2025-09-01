class Persona {
  constructor(identificacion, nombre, correo) {
    this.identificacion = identificacion;
    this.nombre = nombre;
    this.correo = correo;
  }
}

class Aprendiz extends Persona {
  constructor(identificacion, nombre, correo, puntajeIcfes) {
    super(identificacion, nombre, correo);
    this.puntajeIcfes = puntajeIcfes;
  }

  info() {
    console.log("Aprendiz: " + this.nombre +
      " - ID: " + this.identificacion +
      " - Correo: " + this.correo +
      " - ICFES: " + this.puntajeIcfes);
  }
}

class Instructor extends Persona {
  constructor(identificacion, nombre, correo, especialidad) {
    super(identificacion, nombre, correo);
    this.especialidad = especialidad;
  }

  info() {
    console.log("Instructor: " + this.nombre +
      " - ID: " + this.identificacion +
      " - Correo: " + this.correo +
      " - Especialidad: " + this.especialidad);
  }
}

// Uso de las clases
let a1 = new Aprendiz("123", "Juan", "juan@mail.com", 350);
let i1 = new Instructor("456", "Marta", "marta@mail.com", "Matemáticas");

a1.info();
i1.info();
