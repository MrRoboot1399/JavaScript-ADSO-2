let valor=prompt("Que unidad desea convertir a segundos? (minutos= 1, horas= 2)");

if(valor==1){
    let minutos=prompt("Ingrese la cantidad de minutos: ");
    let segundos=minutos*60;
    console.log("La cantidad de segundos es: " + segundos);
}
else if(valor==2){
    let horas=prompt("Ingrese la cantidad de horas: ");
    let segundos=horas*3600;
    console.log("La cantidad de segundos es: " + segundos);
}
