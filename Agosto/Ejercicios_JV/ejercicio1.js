let precio = parseFloat(prompt("Ingrese el precio del producto:"));
let iva = parseFloat(prompt("Ingrese el IVA (%):"));
let total = precio + (precio * iva / 100);
console.log("El precio total a pagar es: $" + total.toFixed(2));
