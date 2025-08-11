let numero = parseInt(prompt("Ingresa un número de dos dígitos:"));

let decenas = Math.floor(numero / 10); 
let unidades = numero % 10;            
console.log("Decenas: " + decenas);
console.log("Unidades: " + unidades);
