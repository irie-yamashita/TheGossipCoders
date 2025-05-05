console.log('📂 Cargando rutas de API');

const express = require('express');
const pool = require('../db/db');
const router = express.Router();

/*endpoint d'exemple*/
router.get('/users', async (req, res) => {
  const { id } = req.query; // Usamos req.query para obtener los parámetros de consulta

  try {
    let result;

    if (id) {
      // Realizamos la consulta en la base de datos usando el 'id'
      result = await pool.query('SELECT * FROM artists WHERE id = $1', [id]);
    } else {
      result = await pool.query('SELECT * FROM users');

    }

    if (result.rows.length > 0) {
      res.json(result.rows);
    } else {
      res.status(404).send('Artista no encontrado');  // Si no se encuentra el artista
    }

  } catch (err) {
    res.status(500).send('Error al obtener usuarios');
  }
});


router.get('/artists', async (req, res) => {
  const { id, limit, name } = req.query; // Usamos req.query para obtener los parámetros de consulta

  try {
    let result;
    
    if (id) {
      // Realizamos la consulta en la base de datos usando el 'id'
      result = await pool.query('SELECT * FROM artists WHERE id = $1', [id]);
    } else if (limit) {
       // Realizamos la consulta en la base de datos usando el 'limit'
       result = await pool.query(`SELECT * FROM artists ORDER BY monthly_listeners DESC LIMIT ${limit}`);
    } else if (name) {
      // Si se pasa 'name', realizar la consulta por nombre del álbum
      result = await pool.query('SELECT * FROM artists WHERE stage_name ILIKE $1', [`%${name}%`]); // Usamos ILIKE para búsqueda insensible a mayúsculas
    } else {
        // Realizamos la consulta en la base de datos usando el 'id'
        result = await pool.query('SELECT * FROM artists ORDER BY monthly_listeners DESC');
    }
   

    if (result.rows.length > 0) {
      res.json(result.rows);  // Si el artista existe, devolver los datos
    } else {
      res.status(404).send('Artista no encontrado');  // Si no se encuentra el artista
    }
  } catch (err) {
    console.error('Error en la consulta a la base de datos:', err);
    res.status(500).send('Error al obtener el/los artista/s');
  }
});


router.get('/albums', async (req, res) => {
  // Obtener los parámetros de la consulta (id, limit, name)
  const { id, limit, name, artist_id} = req.query; // Usamos req.query para obtener los parámetros de consulta

  try {
    let result;

    if (id) {
      // Si se pasa 'id', realizar la consulta por id del álbum
      result = await pool.query('SELECT * FROM albums WHERE id = $1', [id]);
    } else if (name) {
      // Si se pasa 'name', realizar la consulta por nombre del álbum
      result = await pool.query('SELECT * FROM albums WHERE name ILIKE $1', [`%${name}%`]); // Usamos ILIKE para búsqueda insensible a mayúsculas
    } else if (limit) {
      // Si se pasa 'limit', realizar la consulta con límite
      result = await pool.query('SELECT * FROM albums ORDER BY release_date DESC LIMIT $1', [limit]);
    } else if(artist_id){
      result = await pool.query('SELECT * FROM albums WHERE artist_id = $1', [artist_id]);
    } else {
      // Si no se pasa ni 'id', 'name', ni 'limit', devolver todos los álbumes
      result = await pool.query('SELECT * FROM albums');
    }

    if (result.rows.length > 0) {
      res.json(result.rows);  // Devolver los álbumes encontrados
    } else {
      res.status(404).send('Álbum no encontrado');  // Si no se encuentra ningún álbum
    }
  } catch (err) {
    console.error('Error en la consulta a la base de datos:', err);
    res.status(500).send('Error al obtener los álbumes');
  }
});



router.get('/songs', async (req, res) => {
  const { id, limit, title, artist_id} = req.query; // Usamos req.query para obtener los parámetros de consulta

  try {
    let result;
    
    if (id) {
        // Realizamos la consulta en la base de datos usando el 'id'
        result = await pool.query('SELECT * FROM songs WHERE id = $1', [id]);
    } else if(limit) {
      // Realizamos la consulta en la base de datos usando el 'id'
      result = await pool.query(`SELECT * FROM songs ORDER BY play_count DESC LIMIT ${limit}`);
    }else if (title) {
      // Si se pasa 'name', realizar la consulta por nombre del álbum
      result = await pool.query('SELECT * FROM songs WHERE title ILIKE $1', [`%${title}%`]); // Usamos ILIKE para búsqueda insensible a mayúsculas
    } else if(artist_id){
      result = await pool.query('SELECT * FROM songs WHERE artist_id = $1', [artist_id]);
    } else {
        // Realizamos la consulta en la base de datos usando el 'id'
        result = await pool.query('SELECT * FROM songs');
    }
   

    if (result.rows.length > 0) {
      res.json(result.rows);  // Si el artista existe, devolver los datos
    } else {
      res.status(404).send('Canción no encontrada');  // Si no se encuentra el artista
    }
  } catch (err) {
    console.error('Error en la consulta a la base de datos:', err);
    res.status(500).send('Error al obtener la canción');
  }
});


router.get('/plays', async (req, res) => {
  const { user_id} = req.query; // Usamos req.query para obtener los parámetros de consulta

  try {
    let result;

    if (user_id) {
      // Realizamos la consulta en la base de datos usando el 'id'
      result = await pool.query('SELECT * FROM plays WHERE user_id = $1', [user_id]);
    } else {
      // Realizamos la consulta en la base de datos usando el 'id'
      result = await pool.query(`SELECT * FROM plays`);
    }

    if (result.rows.length > 0) {
      res.json(result.rows);  // Si el artista existe, devolver los datos
    } else {
      res.status(404).send('plays no encontrados');  // Si no se encuentra el artista
    }
  } catch (err) {
    res.status(500).send('Error al obtener las plays');
  }
});



module.exports = router;
