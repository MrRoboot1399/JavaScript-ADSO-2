class Estudiante {
  constructor(nombre, materias) {
    this.nombre = nombre;
    this.materias = materias;
  }

  listarMaterias() {
    console.log("Las materias de " + this.nombre + " son: ");
    for (let i = 0; i < this.materias.length; i++) {
      console.log(this.materias[i]);
    }
  }
}

// Uso de la clase Estudiante
let est = new Estudiante("Ana", ["Matemáticas", "Inglés", "Programación"]);
est.listarMaterias();
