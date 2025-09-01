class Producto {
  constructor(nombre, precio) {
    this.nombre = nombre;
    this.precio = precio;
  }
}

class Pedido {
  constructor() {
    this.productos = [];
  }

  agregarProducto(producto) {
    this.productos.push(producto);
  }

  mostrarPedido() {
    console.log("Productos en el pedido:");
    for (let i = 0; i < this.productos.length; i++) {
      console.log(this.productos[i].nombre + " - $" + this.productos[i].precio);
    }
  }
}

// Uso de las clases
let p1 = new Producto("Camisa", 50000);
let p2 = new Producto("Pantalón", 80000);

let pedido = new Pedido();
pedido.agregarProducto(p1);
pedido.agregarProducto(p2);
pedido.mostrarPedido();
