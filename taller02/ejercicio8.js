const prompt = require('prompt-sync')();

let personas = parseInt(prompt("¿Cuántas personas comerán torta de papa?"));

let papaTotal = personas * 200;
let kilosPapa = papaTotal / 1000;

let huevos = kilosPapa * 5;
let cebolla = kilosPapa * 300;

console.log("Papa: " + papaTotal + " gramos");
console.log("Huevos: " + huevos);
console.log("Cebolla: " + cebolla + " gramos");
