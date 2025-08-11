let personas = parseInt(prompt("Ingrese el número de personas:"));
let gramosPapa = personas * 200;
let kilosPapa = gramosPapa / 1000;
let huevos = kilosPapa * 5;
let gramosCebolla = kilosPapa * 300;
console.log("Papa: " + gramosPapa + " gramos");
console.log("Huevos: " + Math.ceil(huevos));
console.log("Cebolla: " + gramosCebolla + " gramos");