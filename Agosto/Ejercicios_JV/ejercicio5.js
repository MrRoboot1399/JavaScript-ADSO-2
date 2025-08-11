let kilometros = parseFloat(prompt("Ingrese los kilómetros recorridos:"));
let litros = parseFloat(prompt("Ingrese los litros consumidos:"));
let consumo = litros / kilometros;
console.log("Consumo de combustible por kilómetro: " + consumo.toFixed(2));