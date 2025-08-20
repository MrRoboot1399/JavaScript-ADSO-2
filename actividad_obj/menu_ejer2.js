const prompt = require('prompt-sync')();

function menu() {
    let opcion = 0;

    do {
        console.clear();
        console.log("MENÚ DE OPCIONES");
        console.log("1. Generar contraseña");
        console.log("2. Contar vocales en una frase");
        console.log("3. Contar números pares en un arreglo");
        console.log("4. Suma y promedio de un arreglo");
        console.log("5. Contar palabras en una frase");
        console.log("6. Invertir un arreglo");
        console.log("7. Eliminar duplicados de un arreglo");
        console.log("8. Convertir nombres a mayúsculas");
        console.log("9. Buscar índice de un valor en un arreglo");
        console.log("10. Reemplazar un valor en un arreglo");
        console.log("11. Países y capitales con Map");
        console.log("12. Suma de dígitos de un número");
        console.log("13. Decimal a binario");
        console.log("14. elecciones candidatos");
        console.log("15. Banco ADSO");
        console.log("0. Salir");
        console.log("=".repeat(40));

        opcion = parseInt(prompt("Ingrese opción: "), 10);

        switch (opcion) {
            case 1: {
                function generarContrasena() {
                    const mayus = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                    const minus = "abcdefghijklmnopqrstuvwxyz";
                    const numeros = "0123456789";
                    const especiales = "@#$%&()=?¿*+[].{}";

                    function obtenerAleatorio(cadena) {
                        return cadena[Math.floor(Math.random() * cadena.length)];
                    }

                    let password = "";
                    for (let i = 0; i < 2; i++) password += obtenerAleatorio(mayus);
                    for (let i = 0; i < 2; i++) password += obtenerAleatorio(minus);
                    for (let i = 0; i < 2; i++) password += obtenerAleatorio(numeros);
                    for (let i = 0; i < 2; i++) password += obtenerAleatorio(especiales);

                    return password.split("").sort(() => Math.random() - 0.5).join("");
                }

                console.log("Contraseña generada: " + generarContrasena());
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 2: { 
                function contarVocales(texto) {
                    let contador = 0;
                    const vocales = "aeiouAEIOU";
                    for (let letra of texto) {
                        if (vocales.includes(letra)) contador++;
                    }
                    return contador;
                }

                let frase = prompt("Ingrese una frase: ");
                console.log("La frase tiene " + contarVocales(frase) + " vocales.");
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 3: { 
                function contarPares(arreglo) {
                    return arreglo.filter(num => num % 2 === 0).length;
                }

                let entrada = prompt("Ingrese números separados por comas: ");
                let arreglo = entrada.split(",").map(n => parseInt(n.trim(), 10));

                console.log("Cantidad de números pares: " + contarPares(arreglo));
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 4: {
                let entrada = prompt("Ingrese números separados por comas: ");
                let arreglo = entrada.split(",").map(n => parseFloat(n.trim()));

                let suma = arreglo.reduce((acc, num) => acc + num, 0);
                let promedio = suma / arreglo.length;

                console.log("Suma = " + suma);
                console.log("Promedio = " + promedio);
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 5: { 
                let frase = prompt("Ingrese una frase: ");
                let palabras = frase.trim().split(/\s+/).length;

                console.log("Cantidad de palabras: " + palabras);
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 6: { 
                let entrada = prompt("Ingrese elementos separados por comas: ");
                let arreglo = entrada.split(",").map(e => e.trim());

                console.log("Arreglo invertido: " + arreglo.reverse());
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 7: { 
                let entrada = prompt("Ingrese elementos separados por comas: ");
                let arreglo = entrada.split(",").map(e => e.trim());

                let sinDuplicados = [...new Set(arreglo)];
                console.log("Arreglo sin duplicados: " + sinDuplicados);
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 8: { 
                let entrada = prompt("Ingrese nombres separados por comas: ");
                let arreglo = entrada.split(",").map(e => e.trim());

                console.log("Nombres en mayúsculas: " + arreglo.map(n => n.toUpperCase()));
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 9: { 
                let entrada = prompt("Ingrese elementos separados por comas: ");
                let arreglo = entrada.split(",").map(e => e.trim());
                let valor = prompt("Ingrese el valor a buscar: ");

                console.log("Índice: " + arreglo.indexOf(valor));
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 10: { 
                let entrada = prompt("Ingrese elementos separados por comas: ");
                let arreglo = entrada.split(",").map(e => e.trim());
                let viejo = prompt("Ingrese el valor a reemplazar: ");
                let nuevo = prompt("Ingrese el nuevo valor: ");

                let resultado = arreglo.map(item => item === viejo ? nuevo : item);
                console.log("Arreglo resultante: " + resultado);
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 11: { 
                const paises = new Map([
                    ["Colombia", "Bogotá"],
                    ["Argentina", "Buenos Aires"],
                    ["Chile", "Santiago"],
                    ["Perú", "Lima"],
                    ["Ecuador", "Quito"],
                    ["México", "Ciudad de México"],
                    ["España", "Madrid"],
                    ["Francia", "París"],
                    ["Italia", "Roma"],
                    ["Alemania", "Berlín"]
                ]);

                let pais = prompt("Ingrese un país: ");
                console.log("Capital: " + (paises.get(pais) || "No encontrado"));
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 12: {
                let nombre = prompt("Ingrese el nombre del producto: ");
                let precio = parseFloat(prompt("Ingrese el precio: "));

                productosSet.add(nombre);
                productosMap.set(nombre, precio);
                historial.push(nombre);

                console.log("Productos únicos: ", productosSet);
                console.log("Precios: ", productosMap);
                console.log("Historial: ", historial);
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 13: {
                function Alumno(nombre, notas) {
                    this.nombre = nombre;
                    this.notas = notas;
                    this.promedio = function () {
                        let suma = this.notas.reduce((a, b) => a + b, 0);
                        return (suma / this.notas.length).toFixed(2);
                    };
                }

                let nombre = prompt("Ingrese el nombre del alumno: ");
                let notas = [];
                for (let i = 0; i < 5; i++) {
                    notas.push(parseFloat(prompt(`Ingrese nota ${i + 1} (1-5): `)));
                }

                let alumno = new Alumno(nombre, notas);
                console.log("Alumno: ", alumno.nombre);
                console.log("Notas: ", alumno.notas);
                console.log("Promedio: ", alumno.promedio());
                prompt("Presiona ENTER para continuar...");
                break;
            }

            case 14: {
    let votos = [0, 0, 0, 0]; 
    let totalVotos = 0;
    const MAX_VOTOS = 50;

    while (true) {
        console.clear();
        console.log("===== ELECCIONES 2025 =====");
        console.log("1. Votar por Candidato Uno");
        console.log("2. Votar por Candidato Dos");
        console.log("3. Votar por Candidato Tres");
        console.log("4. Votar en Blanco");
        console.log("5. Cerrar elecciones");
        console.log("6. Volver al menú principal");
        console.log("============================");
        console.log("Votos actuales: " + totalVotos + "/" + MAX_VOTOS);

        let voto = parseInt(prompt("Ingrese su opción: "), 10);

        if (voto >= 1 && voto <= 4) {
            votos[voto - 1]++;
            totalVotos++;
            console.log("Voto registrado correctamente");
        } else if (voto === 5) {
            let clave = prompt("Ingrese clave para cerrar elecciones: ");
            if (clave === "1234" || totalVotos >= MAX_VOTOS) {
                console.log("\n===== RESULTADOS =====");
                console.log("Total votantes: ", totalVotos);
                console.log("Candidato Uno: ", votos[0]);
                console.log("Candidato Dos: ", votos[1]);
                console.log("Candidato Tres: ", votos[2]);
                console.log("Blanco: ", votos[3]);
                console.log("=======================");
                prompt("Presiona ENTER para volver al menú principal...");
                break;
            } else {
                console.log("Clave incorrecta.");
            }
        } else if (voto === 6) {
            break; // vuelve al menú principal sin cerrar elecciones
        } else {
            console.log("Opción inválida.");
        }

        if (totalVotos >= MAX_VOTOS) {
            console.log("\nSe alcanzó el máximo de votantes.");
            console.log("\n===== RESULTADOS =====");
            console.log("Total votantes: ", totalVotos);
            console.log("Candidato Uno: ", votos[0]);
            console.log("Candidato Dos: ", votos[1]);
            console.log("Candidato Tres: ", votos[2]);
            console.log("Blanco: ", votos[3]);
            console.log("=======================");
            prompt("Presiona ENTER para volver al menú principal...");
            break;
        }

        prompt("Presiona ENTER para continuar...");
    }
    break;
}
            case 15: {
                let cuentas = [];
                let consecutivo = 1;

                function crearCuenta() {
                    let year = new Date().getFullYear();
                    let codigo = `${year}-${consecutivo}`;
                    consecutivo++;
                    let cuenta = {
                        codigo: codigo,
                        fecha: new Date().toLocaleDateString(),
                        saldo: 0
                    };
                    cuentas.push(cuenta);
                    console.log(`Cuenta creada: ${cuenta.codigo}`);
                }

                function consignarCuenta() {
                    let codigo = prompt("Ingrese el código de la cuenta: ");
                    let cuenta = cuentas.find(c => c.codigo === codigo);
                    if (cuenta) {
                        let valor = parseFloat(prompt("Ingrese el valor a consignar: "));
                        if (valor > 0) {
                            cuenta.saldo += valor;
                            console.log(`Consignación exitosa. Nuevo saldo: $${cuenta.saldo}`);
                        } else {
                            console.log("Valor inválido.");
                        }
                    } else {
                        console.log("Cuenta no encontrada.");
                    }
                }

                function retirarCuenta() {
                    let codigo = prompt("Ingrese el código de la cuenta: ");
                    let cuenta = cuentas.find(c => c.codigo === codigo);
                    if (cuenta) {
                        let valor = parseFloat(prompt("Ingrese el valor a retirar: "));
                        if (valor > 0 && valor <= cuenta.saldo) {
                            cuenta.saldo -= valor;
                            console.log(`Retiro exitoso. Nuevo saldo: $${cuenta.saldo}`);
                        } else {
                            console.log("Fondos insuficientes o valor inválido.");
                        }
                    } else {
                        console.log("Cuenta no encontrada.");
                    }
                }

                function consultarCuenta() {
                    let codigo = prompt("Ingrese el código de la cuenta: ");
                    let cuenta = cuentas.find(c => c.codigo === codigo);
                    if (cuenta) {
                        console.log("===== DATOS DE LA CUENTA =====");
                        console.log("Código: " + cuenta.codigo);
                        console.log("Fecha creación: " + cuenta.fecha);
                        console.log("Saldo: $" + cuenta.saldo);
                    } else {
                        console.log("Cuenta no encontrada.");
                    }
                }

                function listarCuentas() {
                    console.log("===== LISTADO DE CUENTAS =====");
                    if (cuentas.length === 0) {
                        console.log("No hay cuentas registradas.");
                    } else {
                        cuentas.forEach(c => {
                            console.log(`Código: ${c.codigo} | Fecha: ${c.fecha} | Saldo: $${c.saldo}`);
                        });
                    }
                }

                // Submenú del banco
                let opcionBanco;
                do {
                    console.log("\n===== MENÚ BANCO ADSO =====");
                    console.log("1. Crear Cuenta");
                    console.log("2. Consignar Cuenta");
                    console.log("3. Retirar Cuenta");
                    console.log("4. Consultar Cuenta Por Código");
                    console.log("5. Listar Cuentas");
                    console.log("6. Volver al menú principal");

                    opcionBanco = parseInt(prompt("Ingrese opción (1-6): "));

                    switch (opcionBanco) {
                        case 1: crearCuenta(); break;
                        case 2: consignarCuenta(); break;
                        case 3: retirarCuenta(); break;
                        case 4: consultarCuenta(); break;
                        case 5: listarCuentas(); break;
                        case 6: console.log("Volviendo al menú principal..."); break;
                        default: console.log("Opción inválida.");
                    }
                } while (opcionBanco !== 6);

                break;
            }

            

            case 0:
                console.log("Saliendo del programa...");
                break;

            default:
                console.log("Opción no válida.");
                prompt("Presiona ENTER para continuar...");
        }
    } while (opcion !== 0);
}

menu();
