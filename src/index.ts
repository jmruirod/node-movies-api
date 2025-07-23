import express from "express";
import swaggerUi from "swagger-ui-express";
import { specs } from "./docs/swagger";

const app = express();

app.use(express.json());

const PORT = 3000;

app.get("/ping", (_req, res) => {
  console.log("someone pinged here!!");
  res.json({ response: "pong" });
});

app.use("/", swaggerUi.serve, swaggerUi.setup(specs));

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
