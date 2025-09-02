import { areacirculo, areatriangulo } from "./funciones.js";

document.getElementById("btnCalcular").addEventListener("click", calcularArea);

function calcularArea() {
  console.log("Entró a la función ");
  const radio = Number(document.getElementById("mono").value);
  const area = areacirculo(radio);
  document.getElementById("txtresultado").value = area;


  
}

document.querySelector("#btnCalcular_trian").addEventListener("click", calcularArea);
const base = Number(document.getElementById("txtresultado_trian").value);
const altura = Number(document.getElementById("txtresultado_trian").value);
const area_trian = areatriangulo(base, altura);
document.getElementById("txtresultado_trian").value = area_trian; 

//document.getElementById("btnCalcular").addEventListener("click", calcularArea);