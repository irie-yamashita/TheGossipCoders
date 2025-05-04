const { Pool, Client } = require('pg');

// Configuración de conexión al pool de base de datos
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

// Función para verificar y crear la base de datos si no existe
async function checkAndCreateDatabase() {
  const client = new Client({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    password: process.env.DB_PASSWORD,
  });

  try {
    // Conectarnos a PostgreSQL sin especificar la base de datos
    await client.connect();
    console.log('Conectado a PostgreSQL');

    // Verificar si la base de datos existe
    const res = await client.query(`
      SELECT 1 FROM pg_database WHERE datname = '${process.env.DB_NAME}';
    `);

    // Si la base de datos no existe, la creamos
    if (res.rowCount === 0) {
      console.log('La base de datos no existe. Creándola...');
      await client.query(`CREATE DATABASE ${process.env.DB_NAME}`);
      console.log('Base de datos creada con éxito');
    } else {
      console.log('La base de datos ya existe');
    }

    // Cerrar la conexión
    await client.end();
  } catch (err) {
    console.error('Error al verificar o crear la base de datos', err);
  }
}

// Llamar a la función para verificar y crear la base de datos
checkAndCreateDatabase();

module.exports = pool;
