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
        <div class="rectange">
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

