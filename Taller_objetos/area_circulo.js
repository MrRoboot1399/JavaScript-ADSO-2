class Circulo {
  constructor(radio) {
    this.radio = radio;
  }

  calcularArea() {
    return 3.1416 * (this.radio * this.radio);
  }
}

// Crear un objeto de tipo Circulo y mostrar el área
let c1 = new Circulo(5);
console.log("El área del círculo es: " + c1.calcularArea());
