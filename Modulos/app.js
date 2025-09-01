import { areacirculo, areatriangulo } from "./funciones.js";
document.querySelector("#btncalcular").addEventListener("click", calcularArea);

function calcularArea() {
    alert("Calculando área del triángulo");
    const radio = document.querySelector("#txtradio").value;
    const area = areacirculo(radio);
    console.log(area);
    document.querySelector("#txtresultado").value = area;
}