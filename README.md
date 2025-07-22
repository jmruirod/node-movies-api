# Backend Node con Typescript template

### Desplegar servidor

```bash
pnpm serve
```

### Parametros en url

Se usan los dos puntos --> /api/users/1

```ts
app.get("/api/users/:id", (request, response) => {
  //Los parametros son strings,
  //si el id es numerico habria que convertirlo
  //Number(request.params.id);
  const id = request.params.id;
  const user = users.find((user) => user.id === id);
  response.json(user);
});
```

### Respuestas personalizadas

```ts
if (user) {
  response.json(user);
} else {
  //Personalisar mensaje status
  response.statusMessage = "Registro no encontrado";
  //end para responder sin datos
  //Los otros metodos ya llevan end al final(send, json, etc)
  response.status(404).end();
}
```

### Eliminar recurso

```ts
app.delete("/api/users/:id", (request, response) => {
  const id = Number(request.params.id);
  users = users.filter((user) => user.id !== id);

  // 204 No content
  response.status(204).end();
});
```

### Crear recurso

```ts
app.post("/api/users", (request, response) => {
  const body = request.body;
  //Comprobar si vienen los datos correctos
  if (!body.name) {
    response.status(400).json({
      error: "name missing",
    });
    // Poner return porque sino seguiria el metodo
    return;
  }
  // Funcion para autoincrementar el id
  const id = generateId();
  const user = { id: id, name: body.name };
  users.push(user);
  console.log(user);
  response.json(user);
});
```

### Middleware

Funciones entre la peticion y la respuesta

**Express comprobará rutas y middlewares en orden de definicion, si se quiere un middleware para todas las rutas tendra que definirse antes de todas las rutas, de la misma forma si se quiere uno para despues de comprobar todas las rutas**

- Propios de express

  ```ts
  /* body no estara disponible si no se define esto antes de definir todas las rutas */

  // app.use para que se ejecute en todas las rutas
  // Parsea Json en todas las rutas
  app.use(express.json());
  ```

- Personalizados

  ```ts
  /* Info de la peticion */
  const requestLogger = (request, response, next) => {
    console.log("Method:", request.method);
    console.log("Path:  ", request.path);
    console.log("Body:  ", request.body);
    console.log("---");
    // Si no se pone next no pasara al siguiente flujo
    // No se pone si es el middleware final
    next();
  };

  // Se ejecutara en todas las peticiones
  app.use(requestLogger);
  ```

  ```ts
  /* Capturar rutas no encontradas*/
  const unknownEndpoint = (request, response) => {
    response.status(404).send({ error: "unknown endpoint" });
    //No tiene next porque es el final
  };

  // Se ejecutara en todas las peticiones
  app.use(unknownEndpoint);
  ```

  ```ts
  /* Para una petición en concreto */
  const validateUser = (req, res, next) => {
    const { name, email } = req.body;

    if (!name || !email) {
      return res.status(400).json({ error: "Nombre y email requeridos" });
    }

    next();
  };

  // Se ejecutará solo en esta peticion
  app.post("/api/users", validateUser, (req, res) => {
    // Solo llega aquí si la validación pasa
    res.json({ message: "Usuario válido" });
  });
  ```

  ```ts
  /* Para una ruta en concreto */
  app.use("/users/:id", (req, res, next) => {
    console.log("Request Type:", req.method);
    next();
  });
  ```

  ```ts
  /* Ejemplo orden */
  const md1 = (_req: express.Request, _res: express.Response, next: express.NextFunction) => {
    console.log("md1");
    next();
  };

  const md2 = (_req: express.Request, _res: express.Response, next: express.NextFunction) => {
    console.log("md2");
    next();
  };

  const unknownEndpoint = (_: express.Request, response: express.Response) => {
    response.status(404).send({ error: "Ruta no encontrada" });
  };

  app.use(md1); // Si no se le pone next no pasara a md2
  app.use(md2); // Si no se le pone next no pasara a unknownEndpoint
  app.use(unknownEndpoint); // Si se pone primero los demas no se ejecutaran
  ```
