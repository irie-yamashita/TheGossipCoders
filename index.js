const express = require('express');
const path = require('path');
const app = express();
const usuariosRouter = require('./routes/usuarios');

const PORT = process.env.PORT || 3000;

app.use(express.static(path.join(__dirname, 'public')));
app.use('/api/usuarios', usuariosRouter); // << Aquí se usa el router

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`Servidor en puerto ${PORT}`);
});
