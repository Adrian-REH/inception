import express from "express";
import Stripe from "stripe";
import cors from "cors";
import * as dotenv from "dotenv";

import morgan from 'morgan';

dotenv.config();

const app = express();
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, { apiVersion: "2025-01-27.acacia" });
app.use(morgan('combined')); // Otras opciones de formato están disponibles

/* app.use(cors({
  origin: 'https://staticpage.42.fr', // Cambia esto por la URL de tu frontend en producción
  methods: ['GET', 'POST'], // Métodos permitidos
  allowedHeaders: ['Content-Type', 'Authorization'] // Headers permitidos
}));app.use(express.json()); // Esto es necesario para poder acceder a req.body
 */
app.post('/procesar-pago', async (Request, Response) => {
    const { token, amount, email } = Request.body;
    console.log(amount)
    try {
      const charge = await stripe.charges.create({
        amount: parseInt(amount),  // Monto del pago en centavos (ej. $20.00)
        currency: 'eur',  // Moneda en la que se realizará el pago
        description: 'Pago de prueba',
        source: token,  // El token que recibimos del cliente
        receipt_email: email,  // Correo electrónico del cliente
      });
  
      // Si el pago es exitoso, respondemos con un mensaje de éxito
      Response.status(200).send({ success: true });
    } catch (error) {
      Response.status(500).send({ success: false, error: error });
    }
});

const port = 3001;
// INICIAR SERVIDOR
app.listen(port, '0.0.0.0', () => console.log(`Servidor corriendo en http://0.0.0.0:${port}`));
