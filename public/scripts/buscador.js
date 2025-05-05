
  document.getElementById("filtro-select").addEventListener("change", function () {
    const filtro = this.value;
    const base = 'busqueda.html';
    window.location.href = filtro ? `${base}?filtro=${filtro}` : base;
  });

  // Opcional: mantener seleccionado el valor actual al cargar
  window.addEventListener("DOMContentLoaded", () => {
    const params = new URLSearchParams(window.location.search);
    const filtro = params.get("filtro");
    if (filtro) {
      document.getElementById("filtro-select").value = filtro;
    }
  });


document.addEventListener("DOMContentLoaded", () => {
    const input = document.getElementById("search");
    const resultados = document.getElementById("resultados");

    // Obtener el valor del filtro desde la URL (por ejemplo: ?filtro=artist)
    const params = new URLSearchParams(window.location.search);
    const filtro = params.get("filtro"); // puede ser null, 'artist', 'song', 'album'

    input.addEventListener("input", async () => {
        const query = input.value.trim();

        if (!query) {
            resultados.innerHTML = "";
            return;
        }

        try {
            // Construir la URL con el filtro si existe
            let url = `/api/buscar?q=${encodeURIComponent(query)}`;
            if (filtro) {
                url += `&filtro=${encodeURIComponent(filtro)}`;
            }

            const res = await fetch(url);
            if (!res.ok) throw new Error("Error en la búsqueda");

            const data = await res.json();

            if (data.length === 0) {
                resultados.innerHTML = "<li>No se encontraron resultados</li>";
                return;
            }

            resultados.innerHTML = data.map(item => {
                let detalleUrl = '';
            
                // Verifica si el tipo es artista o canción, pero no para álbum
                if (item.tipo === 'artista') {
                    detalleUrl = `detalle_artistas.html?id=${item.id}`;
                } else if (item.tipo === 'cancion') {
                    detalleUrl = `detalle_cancion.html?id=${item.id}`;
                }
            
                // Si no es artista ni canción (por ejemplo, un álbum), no genera enlace
                if (!detalleUrl) {
                    return `
                        <li>
                            <strong>${item.nombre}</strong> <em>(${item.tipo})</em>
                        </li>
                    `;
                }
            
                return `
                    <li>
                        <a href="${detalleUrl}">
                            <strong>${item.nombre}</strong> <em>(${item.tipo})</em>
                        </a>
                    </li>
                `;
            }).join("");
            

        } catch (err) {
            console.error(err);
            resultados.innerHTML = "<li>Error al buscar resultados</li>";
        }
    });
});

// Espera a que el DOM esté completamente cargado antes de ejecutar
document.addEventListener("DOMContentLoaded", () => {
    // Selecciona el contenedor donde se mostrarán las canciones recomendadas
    const listaRecomendados = document.getElementById('recomendados');

    // Realiza la petición para obtener las canciones recomendadas (limitadas a 4)
    fetch('/api/songs?limit=4')
        .then(response => response.json())
        .then(data => {
            // Limpia el contenido de la lista (por si ya tiene elementos)
            listaRecomendados.innerHTML = '';

            // Inserta las canciones en la lista
            data.forEach((cancion, index) => {
                // Crea el item de la lista (li)
                const li = document.createElement('section');

                // Crear el enlace que envuelve toda la información de la canción
                const enlace = document.createElement('a');
                enlace.href = `detalle_cancion.html?id=${cancion.id}`;  // Enlace a detalle_cancion.html pasando el id de la canción
                enlace.style.textDecoration = 'none';  // Opcional: quita el subrayado del enlace

                // Crear el contenido de la canción
                li.innerHTML = `
                    <h3>${cancion.title}</h3>
                `;

                // Añadir el contenido de la canción al enlace
                enlace.appendChild(li);

                // Añadir el enlace a la lista
                listaRecomendados.appendChild(enlace);
            });
        })
        .catch(error => {
            console.error('Error al obtener las canciones recomendadas:', error);
            listaRecomendados.innerHTML = '<li>Error al cargar las canciones recomendadas</li>';
        });
});
