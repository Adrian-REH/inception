import express from "express";
import Stripe from "stripe";
import cors from "cors";
import * as dotenv from "dotenv";
import { Request, Response } from "express";
import path from 'path';

import morgan from 'morgan';

dotenv.config();

const app = express();
app.use(morgan('combined')); // Otras opciones de formato están disponibles

app.use(cors());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json()); // Esto es necesario para poder acceder a req.body

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
  });



const port = 3030;
// INICIAR SERVIDOR
app.listen(port, '0.0.0.0', () => console.log(`Servidor corriendo en http://localhost:${port}`));
