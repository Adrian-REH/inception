// Este es el código para procesar el formulario con Stripe

// Aquí debes colocar tu clave pública de Stripe
const stripe = Stripe('pk_test_51Qn0ZQGfkydL0eslH568mPRTnGR2wLBsyTCvRSHjD5ZrIFGbgFSZtZqi9sUP2nbMGC2wsPn06HTp6wzD3YCIABoP00kGrejnzX'); // Sustituye con tu clave pública de Stripe
const elements = stripe.elements();
const donationInput = document.getElementById('donation-input');
const donationAmountDisplay = document.getElementById('donation-amount');

// Crear el elemento de la tarjeta
const card = elements.create('card');
card.mount('#card-element');

// Manejar el envío del formulario
const form = document.getElementById('payment-form');
const listPayments = document.getElementById('payments-list');

function addAceptedPayment() {
    const li = document.createElement('li');
    li.classList.add('card');  // Agregar la clase card a cada elemento de la lista
    li.textContent = `Donacion de $${(parseInt(donationInput.value) || 0)} Aceptada`;

    // Asignar color según el monto (por ejemplo, verde para montos positivos y rojo para montos negativos)
    li.classList.add('green');

    listPayments.appendChild(li);
}

function addCancelPayment() {
    const li = document.createElement('li');
    li.classList.add('card');  // Agregar la clase card a cada elemento de la lista

    li.textContent = `Donacion de $${(parseInt(donationInput.value) || 0)} Cancelada`;

    // Asignar color según el monto (por ejemplo, verde para montos positivos y rojo para montos negativos)
    li.classList.add('red');

    listPayments.appendChild(li);
}


function updateDonationAmount() {
    const amount = parseFloat(donationInput.value) || 0;  // Evitar NaN
    donationAmountDisplay.textContent = amount.toFixed(2);  // Mostrar el monto con dos decimales
}
donationInput.addEventListener('input', updateDonationAmount);

form.addEventListener('submit', async (event) => {
  event.preventDefault();

  // Crear el token para el pago
  const { token, error } = await stripe.createToken(card);
  if (error) {
    // Si ocurre un error, lo mostramos en la consola
    console.error(error);
    alert('Hubo un error con el pago: ' + error.message);
  } else {
    // Si no hay errores, podemos enviar el token al servidor
    console.log('Token:', token);

    // Aquí podrías enviar el token al servidor para procesar el pago
    // Ejemplo con fetch:
    const response = await fetch('http://paymentsrv:3001/procesar-pago', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        token: token.id,
        amount: parseInt(donationInput.value) || 0,
        email: document.getElementById('email').value
      })
    });

    if (response.ok) {
      // Si el pago fue exitoso, redirige al usuario
        addAceptedPayment()
    } else {
        addCancelPayment()
      // Si algo salió mal, puedes redirigir a una página de error
    }
  }
});
