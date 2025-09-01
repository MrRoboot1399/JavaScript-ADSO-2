class Autor {
  constructor(nombre) {
    this.nombre = nombre;
  }
}

class Editorial {
  constructor(nombre) {
    this.nombre = nombre;
  }
}

class Libro {
  constructor(titulo, autor, editorial) {
    this.titulo = titulo;
    this.autor = autor;
    this.editorial = editorial;
  }

  mostrarInfo() {
    console.log("Libro: " + this.titulo +
      " | Autor: " + this.autor.nombre +
      " | Editorial: " + this.editorial.nombre);
  }
}

// Uso de las clases
let autor1 = new Autor("Gabriel García Márquez");
let editorial1 = new Editorial("Editorial Sudamericana");

let libro1 = new Libro("Cien años de soledad", autor1, editorial1);
libro1.mostrarInfo();
