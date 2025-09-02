import Alcancia from "./alcancia.js";

const miAlcancia = new Alcancia();

// Evento cuando hago click en una moneda
document.querySelectorAll(".img-moneda").forEach(img => {
  img.addEventListener("click", () => {
    const valor = Number(img.dataset.valor);

    // Se guarda en la alcancía
    miAlcancia.agregarMoneda(valor);

    // Se muestran los resultados en pantalla
    document.getElementById("total").innerText = `Total: $${miAlcancia.getTotal()}`;
    document.getElementById(`contador${valor}`).innerText = `Monedas ${valor}: ${miAlcancia.getContador(valor)}`;
  });
});

// Evento para ROMPER la alcancía
document.getElementById("romper").addEventListener("click", () => {
  const resumen = miAlcancia.romper();

  alert(`¡Rompiste la alcancía!\nTotal: $${resumen.total}\n- Monedas 200: ${resumen.monedas200}\n- Monedas 500: ${resumen.monedas500}\n- Monedas 1000: ${resumen.monedas1000}`);

  // Reset en pantalla
  document.getElementById("total").innerText = "Total: $0";
  document.getElementById("contador200").innerText = "Monedas 200: 0";
  document.getElementById("contador500").innerText = "Monedas 500: 0";
  document.getElementById("contador1000").innerText = "Monedas 1000: 0";
});
