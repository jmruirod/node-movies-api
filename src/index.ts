// Importa el framework Express para crear el servidor web
import express from "express";
// Importa swagger-ui-express para servir la interfaz de documentación de la API
import swaggerUi from "swagger-ui-express";
// Importa la configuración de Swagger desde el archivo de documentación
import { specs } from "./docs/swagger";

// Crea una instancia de la aplicación Express
const app = express();

// Middleware para parsear automáticamente el JSON en las peticiones
app.use(express.json());

// Define el puerto donde correrá el servidor
const PORT = 3000;

// Define una ruta GET en "/ping" que responde con un JSON
/**
 * @swagger
 * /ping:
 *   get:
 *     summary: Endpoint de prueba para verificar que el servidor está funcionando
 *     description: Responde con un mensaje "pong" para confirmar que el servidor está activo
 *     tags:
 *       - Health Check
 *     responses:
 *       200:
 *         description: Servidor funcionando correctamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 response:
 *                   type: string
 *                   example: "pong"
 *                   description: Mensaje de confirmación del servidor
 */
app.get("/ping", (_req, res) => {
  // Imprime un mensaje en la consola cuando alguien hace ping
  console.log("someone pinged here!!");
  // Responde con un objeto JSON que contiene "pong"
  res.json({ response: "pong" });
});

// Configura Swagger UI para servir la documentación de la API en la ruta raíz "/"
// swaggerUi.serve sirve los archivos estáticos de Swagger UI
// swaggerUi.setup(specs) configura la interfaz con las especificaciones de la API
app.use("/", swaggerUi.serve, swaggerUi.setup(specs));

// Inicia el servidor en el puerto especificado
app.listen(PORT, () => {
  // Callback que se ejecuta cuando el servidor está listo
  console.log(`Server running on port ${PORT}`);
});
