const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("🚀 Node.js 18.12.1 rodando no Docker!");
});

// IMPORTANTE → ouvir em 0.0.0.0 (não só localhost)
app.listen(3000, "0.0.0.0", () => {
  console.log("Servidor Node rodando na porta 3000");
});
