const express = require('express');
const bcrypt = require('bcryptjs');
const pool = require('../db/db'); // Tu pool de conexión a la base de datos
const router = express.Router();

// Ruta para registrar un nuevo usuario
router.post('/register', async (req, res) => {
    const { name, email, password } = req.body;

    // Validar que los campos no estén vacíos
    if (!name || !email || !password) {
        return res.status(400).json({ message: 'El nombre, correo y contraseña son obligatorios.' });
    }

    try {
        // Verificar si el correo ya está registrado
        const emailExists = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
        if (emailExists.rows.length > 0) {
            return res.status(400).json({ message: 'El correo ya está registrado.' });
        }

        // Cifrar la contraseña
        const hashedPassword = await bcrypt.hash(password, 10);

        // Insertar el nuevo usuario en la base de datos
        const result = await pool.query(
            'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING id, name, email, registration_date',
            [name, email, hashedPassword]
        );

        // Responder con los datos del usuario registrado
        res.status(201).json({
            message: 'Usuario registrado con éxito',
            user: result.rows[0]
        });
    } catch (err) { 
        console.error('Error al registrar el usuario:', err);
        res.status(500).json({ message: 'Error al registrar el usuario.', error: err.message });
    }
});

module.exports = router;
