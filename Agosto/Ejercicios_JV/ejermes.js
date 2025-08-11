const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question('Ingresa un número hasta 12: ', (input) => {
    const mes = parseInt(input, 10);

switch (mes) {
    case 1:
        console.log("Enero");
        break;
    case 2:
        console.log("febrero");
        break;
    case 3:
        console.log("Marzo");
        break;
    case 4:
        console.log("Abril");
        break;
    case 5:
        console.log("Mayo");
        break;
    case 6:
        console.log("Junio");
        break;
    case 7:
        console.log("Julio");
        break;
    case 8:
        console.log("Agosto");
        break;
    case 9:
        console.log("Septiembre");
        break;
    case 10:
        console.log("Octubre");
        break;
    case 11:
        console.log("Noviembre");
        break;      
    case 12:
        console.log("Diciembre");
        break;

    default:
        console.log("Mes no válido");
        break;
}
    rl.close();
});              
