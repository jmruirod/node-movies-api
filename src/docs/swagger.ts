import swaggerJSDoc from "swagger-jsdoc";

const swaggerOptions = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Mi API",
      version: "1.0.0",
      description: "API de ejemplo con TypeScript y Express",
    },
    servers: [
      {
        url: "http://localhost:3000",
        description: "Servidor de desarrollo",
      },
    ],
  },
  apis: ["./src/*.ts"], // Rutas a los archivos que contienen las anotaciones
};

export const specs = swaggerJSDoc(swaggerOptions);
