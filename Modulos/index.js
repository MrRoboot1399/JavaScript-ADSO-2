import { hello, magicNumber, bye} from "./constante.js"; // Importa la constante desde el archivo constante.js 
import persona from "./persona.js";
// Muestra el valor de la constante en la consola
console.log(magicNumber); 
console.log(hello());
console.log(bye());

import defecto from "./constante.js"; // importa el default, y no va con llaves
console.log(defecto);
const per = new persona("carlos", "jfgiraldo@gmail.com")
per.saludar();
console.log(per.getcorreo());

listaLibros = [
    { 
        titulo: "El amor en los tiempos del cólera",
        autor: "Gabriel García Márquez",
        paginas: 348,
        editorial: "Penguin Random House",
        idioma: "Español"
    },
]
console.log(listaLibros);