const express = require('express');
const pool = require('../db/db');
const router = express.Router();

/*endpoint d'exemple*/
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM usuarios');
    res.json(result.rows);
  } catch (err) {
    res.status(500).send('Error al obtener usuarios');
  }
});

module.exports = router;
