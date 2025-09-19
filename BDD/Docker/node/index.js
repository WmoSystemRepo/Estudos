const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("🚀 Node.js 18.12.1 rodando no Docker!");
});

// ouvir em 0.0.0.0 para aceitar conexões do host
app.listen(3000, "0.0.0.0", () => {
  console.log("Servidor Node rodando na porta 3000");
});
