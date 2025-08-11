const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question('Ingresa un número de dos dígitos: ', (input) => {
    const numero = parseInt(input, 10);

    if ((numero >= 10 && numero <= 99) || (numero <= -10 && numero >= -99)) {
        console.log("¡Correcto! El número " + numero + " tiene dos dígitos.");
    } else {
        console.log("Incorrecto. El número " + numero + " no tiene dos dígitos.");
    }
    rl.close();
});


    

