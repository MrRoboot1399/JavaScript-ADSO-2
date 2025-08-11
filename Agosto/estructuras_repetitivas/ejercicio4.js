const prompt = require('prompt-sync')();

function menu() {
    let opcion = 0;

    do {
        console.clear();
        console.log("MENÚ DE OPCIONES");
        console.log("1. Área del Círculo");
        console.log("2. Adivinar Número entre 1 y 100 (máx 5 intentos)");
        console.log("3. Salir");
        console.log("=");

        opcion = parseInt(prompt("Ingrese opción: "));

        switch (opcion) {
            case 1:
                console.clear();
                console.log("ÁREA DEL CÍRCULO");
                let radio = parseFloat(prompt("Ingrese el radio del círculo: "));
                if (radio > 0) {
                    let area = Math.PI * Math.pow(radio, 2);
                    console.log(`El área del círculo es: ${area.toFixed(2)}`);
                } else {
                    console.log("El radio debe ser un número positivo.");
                }
                break;

            case 2:
                console.clear();
                console.log("ADIVINAR NÚMERO");
                let numeroSecreto = Math.floor(Math.random() * 100) + 1;
                let intento;
                let intentos = 0;
                let maxIntentos = 5;

                do {
                    intento = parseInt(prompt(`Intento ${intentos + 1} de ${maxIntentos}. Adivina el número (1-100): `));
                    intentos++;

                    if (intento > numeroSecreto) {
                        console.log("Muy alto, intente de nuevo.");
                    } else if (intento < numeroSecreto) {
                        console.log("Muy bajo, intente de nuevo.");
                    } else {
                        console.log(`¡Correcto! Lo adivinaste en ${intentos} intentos.`);
                        break; 
                    }

                } while (intento !== numeroSecreto && intentos < maxIntentos);

                if (intento !== numeroSecreto) {
                    console.log(`lo siento, se acabaron tus intentos . El número era ${numeroSecreto}.`);
                }
                break;

            case 3:
                console.log("Saliendo del programa...");
                break;

            default:
                console.log("Opción no válida, intenta de nuevo.");
        }

        if (opcion !== 3) {
            prompt("Presiona Enter para continuar...");
        }

    } while (opcion !== 3);
}


menu();
