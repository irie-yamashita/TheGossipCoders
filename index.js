const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');
const express = require('express');
const usuariosRouter = require('./routes/api'); // Asegúrate de que esta ruta sea correcta
const app = express();

const PORT = process.env.PORT || 3000; // Define el puerto si no lo tienes en .env

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

// Función para ejecutar el archivo SQL de inicialización
async function executeSQLFile() {
  try {
    const sql = fs.readFileSync('./db/init.sql', 'utf8'); // Asegúrate que el archivo esté en esta ruta
    await pool.query(sql); // Usa await para esperar que se ejecute correctamente
    console.log('Archivo SQL ejecutado correctamente');
  } catch (err) {
    console.error('Error al ejecutar el archivo SQL:', err);
  }
}

// Ejecutar el SQL cuando arranque el servidor
executeSQLFile();

app.use(express.static(path.join(__dirname, 'public')));
app.use('/api', usuariosRouter);

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Arrancar el servidor
app.listen(PORT, () => {
  console.log(`Servidor en puerto ${PORT}`);
  console.log('🚀 El servidor está funcionando correctamente');
});
