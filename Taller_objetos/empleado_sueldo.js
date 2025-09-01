class empleado {

    constructor(nombre, sueldo) {
        this.nombre = nombre;
        this.sueldo = sueldo;
    }

        aumentoSueldo(porcentaje) {
            this.sueldo += this.sueldo*porcentaje/100;
        }

        obtenerSueldo() {
            return this.sueldo;
        }
    }
    let empl1 = new empleado("Juan", 2000);
    empl1.aumentoSueldo(10);
    console.log("El sueldo de " + empl1.nombre + " es: " + empl1.obtenerSueldo());


//funcion getter y setter

class Usuario {
    constructor(nombre, correo) {
        this.nombre = nombre;
        this.correo = correo;
  }

    setCorreo(nuevoCorreo) {
        this.correo = nuevoCorreo;
  }

    getCorreo() {
        return this.correo;
  }
}

// Probar la clase Usuario
let u1 = new Usuario("juan", "jf1399@gmail.com");
console.log("Correo inicial: " + u1.getCorreo());
u1.setCorreo("jf1399@gmail.com");
console.log("Correo actualizado: " + u1.getCorreo());



