// Datos artistas
fetch('/api/artists?limit=6')
    .then(response => response.json())
    .then(data => {
        const lista = document.getElementById('artistas_container');

        lista.innerHTML = data.map(artista => `
      <div class="quadrat">
        <h3>${artista.stage_name}</h3>
        <a href="detalle_artistas.html?id=${artista.id}">
          <img src="${artista.photo_url}" alt="${artista.stage_name}">
        </a>
      </div>
    `).join('');
    })
    .catch(error => {
        console.error('Error al obtener los artistas:', error);
    });


// Datos canciones
fetch('/api/songs?limit=5')
    .then(response => response.json())
    .then(data => {
        const lista = document.getElementById('canciones_container');

        lista.innerHTML = data.map((cancion, index) => `
      <div class="quadrat" style="cursor: pointer;" onclick="window.location.href='detalle_cancion.html?id=${cancion.id}'">
        <p>${index + 1}</p>
        <h3>${cancion.title}</h3>
        <p>Reproducciones: <strong>${cancion.play_count.toLocaleString('es-ES')}</strong></p>
      </div>
    `).join('');
    })
    .catch(error => {
        console.error('Error al obtener las canciones:', error);
    });



//Datos álbumes
fetch('/api/albums?limit=5')
    .then(response => response.json())
    .then(data => {
        const lista = document.getElementById('albumes_container');

        lista.innerHTML = data.map((album, index) => {
            const fecha = new Date(album.release_date);
            const fechaFormateada = isNaN(fecha) ? 'Fecha desconocida' : fecha.toLocaleDateString('es-ES');

            return `
        <div class="rectangle">
          <h3>${index + 1}. ${album.name}</h3>
          <img src="${album.photo_url || 'img/default_album.png'}" alt="${album.name}">
          <p class="color">Publicado el: ${fechaFormateada}</p>
        </div>
      `;
        }).join('');
    })
    .catch(error => {
        console.error('Error al obtener los álbumes:', error);
    });



// Función para cargar más artistas
document.getElementById("verMasArtistas").addEventListener("click", async () => {
    const res = await fetch("/api/artists?limit=5");
    const artistas = await res.json();
    const contenedor = document.getElementById("artistas_container");

    // Por cada artista que recibimos, agregamos un div con el nombre y la imagen
    artistas.forEach(artista => {
        const div = document.createElement("div");
        div.innerHTML = `
                <h3>${artista.stage_name}</h3>
                <a href="detalle_artistas.html?name=${artista.stage_name}"><img src="${artista.image}" alt="${artista.stage_name}"></a>
            `;
        contenedor.appendChild(div);
    });
});

// Función para cargar más canciones
document.getElementById("verMasCanciones").addEventListener("click", async () => {
    const res = await fetch("/api/songs?limit=5");
    const canciones = await res.json();
    const contenedor = document.getElementById("canciones_container");

    // Por cada canción que recibimos, agregamos un div con el nombre y la imagen
    canciones.forEach(cancion => {
        const div = document.createElement("div");
        div.innerHTML = `
                <h3>${cancion.name}</h3>
                <a href="detalle_cancion.html"><img src="${cancion.imagen}" alt="${cancion.name}"></a>
            `;
        contenedor.appendChild(div);
    });
});

// Función para cargar más álbumes
document.getElementById("verMasAlbumes").addEventListener("click", async () => {
    const res = await fetch("/api/albums?limit=5");
    const albumes = await res.json();
    const contenedor = document.getElementById("albumes_container");

    // Por cada álbum que recibimos, agregamos un div con el nombre y la imagen
    albumes.forEach(album => {
        const div = document.createElement("div");
        div.innerHTML = `
                <h3>${album.nombre}</h3>
                <img src="${album.imagen_url}" alt="${album.nombre}">
            `;
        contenedor.appendChild(div);
    });
});