const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question('Ingresa un número: ', (input) => {
    const numero = parseInt(input, 10);

    if (isNaN(numero)) {
        console.log('No ingresaste un número válido.');
    } else if (numero % 2 === 0) {
        console.log('El número es par.');
    } else {
        console.log('El número es impar.');
    }

    rl.close();
});