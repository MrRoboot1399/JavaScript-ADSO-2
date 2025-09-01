export default class persona {
    constructor(nombre, correo) {
        this.nombre = nombre;
        this.correo = correo;
    }
    saludar() {
        console.log("Hola, mi nombre es " + this.nombre);
    }
    getcorreo() {
        return this.correo;
    }
}
