const prompt = require('prompt-sync')();

let valor= parseInt(prompt("Ingrese el valor: "));
let esPar= (valor % 2 === 0);

console.log(esPar)

