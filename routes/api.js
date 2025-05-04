console.log('📂 Cargando rutas de API');

const express = require('express');
const pool = require('../db/db');
const router = express.Router();

/*endpoint d'exemple*/
router.get('/usuarios', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM usuarios');
    res.json(result.rows);
  } catch (err) {
    res.status(500).send('Error al obtener usuarios');
  }
});

router.get('/artists', async (req, res) => {
  console.log('🔍 Entrando en /artists');
  try {
    console.log('👀 Ejecutando la consulta a la base de datos');
    const result = await pool.query('SELECT * FROM artists');
    res.json(result.rows);
  } catch (err) {
    console.error('❌ Error en /artists:', err);
    res.status(500).send('Error al obtener artistas');
  }
});





router.get('/test', (req, res) => {
  console.log('🎯 Entrando en /test');
  res.send('Test OK');
});


module.exports = router;
