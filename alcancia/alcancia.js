export default class Alcancia {
  constructor() {
    this.total = 0;
    this.contadores = {
      200: 0,
      500: 0,
      1000: 0
    };
  }

  agregarMoneda(valor) {
    this.total += valor;
    this.contadores[valor]++;
  }

  getTotal() {
    return this.total;
  }

  getContador(valor) {
    return this.contadores[valor];
  }

  romper() {
    const resumen = {
      total: this.total,
      monedas200: this.contadores[200],
      monedas500: this.contadores[500],
      monedas1000: this.contadores[1000]
    };

    // Reiniciar valores
    this.total = 0;
    this.contadores = {200: 0, 500: 0, 1000: 0};

    return resumen;
  }
}
