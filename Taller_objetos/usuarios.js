class Usuario {
  constructor(nombre, correo) {
    this.nombre = nombre;
    this._correo = correo;
  }

  setCorreo(nuevoCorreo) {
    this._correo = nuevoCorreo;
  }

  getCorreo() {
    return this._correo;
  }
}

// Uso de la clase
let u1 = new Usuario("Lucía", "lucia@mail.com");
console.log("Correo inicial: " + u1.getCorreo());
u1.setCorreo("lucia2025@mail.com");
console.log("Correo actualizado: " + u1.getCorreo());
