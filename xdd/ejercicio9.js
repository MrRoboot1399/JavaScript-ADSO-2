const prompt = require('prompt-sync')();

let valor1= parseFloat(prompt("Ingrese el primer valor: "));
let valor2= parseFloat(prompt("Ingrese el segundo valor: "));

let temp= valor1;
valor1 = valor2;
valor2 = temp;

console.log("El primer valor es: " + valor1);
console.log("El segundo valor es: " + valor2);




