let a = prompt("Ingrese el valor de la variable A:");
let b = prompt("Ingrese el valor de la variable B:");
let temp = a;
a = b;
b = temp;
console.log("Nuevo valor de A: " + a);
console.log("Nuevo valor de B: " + b);