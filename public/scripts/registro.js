document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

    form.addEventListener("submit", async (event) => {
        event.preventDefault(); // Evitar que se recargue la página al enviar el formulario

        const userName = document.getElementById("user_name").value.trim();
        const password = document.getElementById("password_user").value.trim();
        const confirmPassword = document.getElementById("password_user2").value.trim();
        const email = document.getElementById("email_user").value.trim();


        // Validar los campos
        if (!userName || !password || !confirmPassword) {
            alert("Todos los campos son obligatorios.");
            return;
        }

        if (password !== confirmPassword) {
            alert("Las contraseñas no coinciden.");
            return;
        }

        try {
            // Enviar solicitud POST para crear un nuevo usuario
            const res = await fetch('/api/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    name: userName,
                    password: password
                })
            });

            const data = await res.json();

            if (res.ok) {
                alert("¡Registro exitoso!");
                window.location.href = "log_in.html"; // Redirigir al login
            } else {
                alert(data.message || "Hubo un error en el registro.");
            }

        } catch (err) {
            console.error("Error:", err);
            alert("Hubo un error al procesar tu solicitud.");
        }
    });
});
