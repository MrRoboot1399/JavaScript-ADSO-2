const prompt = require('prompt-sync')();

function menu() {
    let opcion = 0;

    do {
        console.clear();
        console.log("MENÚ DE OPCIONES");
        console.log("1. Número par o impar");
        console.log("2. Suma de los dígitos de un número");
        console.log("3. Saber si un número es primo");
        console.log("4. Contar vocales en una frase");
        console.log("5. Tabla de multiplicar de un número");
        console.log("6. Calcular el factorial de un número");
        console.log("7. Imprimir números del 1 al 100");
        console.log("8. Imprimir números pares hasta un número");
        console.log("9. Imprimir números impares hasta un número");
        console.log("10. Repetir una frase N veces");
        console.log("11. Factorial de un número (alternativo)");
        console.log("12. Suma pares y promedio impares");
        console.log("13. Decimal a binario");
        console.log("14. Salir");
        console.log("=".repeat(40));

        opcion = parseInt(prompt("Ingrese opción: "), 10);

        switch (opcion) {
            case 1: { // Par o impar
                const numero = parseInt(prompt('Ingresa un número: '), 10);
                if (isNaN(numero)) {
                    console.log('No ingresaste un número válido.');
                } else if (numero % 2 === 0) {
                    console.log('El número es par.');
                } else {
                    console.log('El número es impar.');
                }
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 2: { // Suma de dígitos
                let numero = Math.abs(parseInt(prompt("Ingresa un número: "), 10));
                if (isNaN(numero)) {
                    console.log("Número inválido");
                } else {
                    let suma = 0;
                    while (numero > 0) {
                        suma += numero % 10;
                        numero = Math.floor(numero / 10);
                    }
                    console.log(`La suma de los dígitos es: ${suma}`);
                }
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 3: { // Número primo
                let num = parseInt(prompt("Ingrese un número: "), 10);
                if (num <= 1) {
                    console.log("No es primo");
                } else {
                    let primo = true;
                    for (let i = 2; i <= Math.sqrt(num); i++) {
                        if (num % i === 0) {
                            primo = false;
                            break;
                        }
                    }
                    console.log(primo ? "Es primo" : "No es primo");
                }
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 4: { // Contar vocales
                let frase = prompt("Ingrese una frase: ");
                let conteo = (frase.match(/[aeiouáéíóú]/gi) || []).length;
                console.log(`La frase tiene ${conteo} vocales.`);
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 5: { // Tabla de multiplicar
                let num = parseInt(prompt("Ingrese un número: "), 10);
                for (let i = 1; i <= 10; i++) {
                    console.log(`${num} x ${i} = ${num * i}`);
                }
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 6: { // Factorial
                let num = parseInt(prompt("Ingrese un número: "), 10);
                let fact = 1;
                for (let i = 1; i <= num; i++) fact *= i;
                console.log(`El factorial es: ${fact}`);
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 7: { // Números del 1 al 100
                for (let i = 1; i <= 100; i++) {
                    process.stdout.write(i + " ");
                }
                console.log();
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 8: { // Pares hasta N
                let num = parseInt(prompt("Ingrese un número: "), 10);
                for (let i = 2; i <= num; i += 2) {
                    process.stdout.write(i + " ");
                }
                console.log();
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 9: { // Impares hasta N
                let num = parseInt(prompt("Ingrese un número: "), 10);
                for (let i = 1; i <= num; i += 2) {
                    process.stdout.write(i + " ");
                }
                console.log();
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 10: { // Repetir frase N veces
                let veces = parseInt(prompt("Ingrese un número entre 1 y 20: "), 10);
                let frase = prompt("Ingrese una frase: ");
                if (veces >= 1 && veces <= 20) {
                    for (let i = 1; i <= veces; i++) {
                        console.log(`${i}. ${frase}`);
                    }
                } else {
                    console.log("Número fuera de rango");
                }
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 11: { // Factorial alternativo
                let num = parseInt(prompt("Ingrese un número: "), 10);
                let fact = 1;
                for (let i = 1; i <= num; i++) fact *= i;
                console.log(`El factorial de ${num} es ${fact}`);
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 12: { // Suma pares y promedio impares
                let sumaPares = 0, sumaImpares = 0, contadorImpares = 0;
                for (let i = 1; i <= 10; i++) {
                    let num = parseInt(prompt(`Ingrese número ${i}: `), 10);
                    if (num % 2 === 0) {
                        sumaPares += num;
                    } else {
                        sumaImpares += num;
                        contadorImpares++;
                    }
                }
                let promedioImpares = contadorImpares > 0 ? (sumaImpares / contadorImpares) : 0;
                console.log(`Suma de pares: ${sumaPares}`);
                console.log(`Promedio de impares: ${promedioImpares}`);
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 13: { // Decimal a binario
                let num = parseInt(prompt("Ingrese un número decimal: "), 10);
                console.log(`En binario: ${num.toString(2)}`);
                prompt("Presiona Enter para continuar...");
                break;
            }

            case 14:
                console.log("Saliendo del programa...");
                break;

            default:
                console.log("Opción no válida, por favor intente de nuevo.");
                prompt("Presiona Enter para continuar...");
        }
    } while (opcion !== 14);
}

menu();
