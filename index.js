const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

// 1) Sirve todo lo que haya en /public
app.use(express.static(path.join(__dirname, 'public')));

// 2) Ruta principal
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html')); // Servir el archivo index.html
});

// 3) Escuchar en el puerto
app.listen(PORT, () => {
  console.log(`Servidor escuchando en puerto ${PORT}`);
});
