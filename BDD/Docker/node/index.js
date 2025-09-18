const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("🚀 Node.js 18.12.1 rodando no Docker!");
});

app.listen(3000, () => {
  console.log("Servidor rodando na porta 3000");
});
