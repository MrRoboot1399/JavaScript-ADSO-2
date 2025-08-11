/* Mostrar en pantalla los múltiplos de 3 entre dos números ingresados por teclado */

const prompt = require("prompt-sync")();
const numero1 = parseInt(prompt("Ingrese número entero inferior: "));
const numero2 = parseInt(prompt("Ingrese número superior: "));

let mayor, menor;

if (numero1 > numero2) {
    mayor = numero1;
    menor = numero2;
} else {
    mayor = numero2;
    menor = numero1;
}

for (let i = menor; i <= mayor; i++) {
    if (i % 3 === 0) {
        console.log(i);
    }
}