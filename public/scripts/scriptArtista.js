
//Boton de favorito
const favBtn = document.getElementById('favBtn');
const artista = document.getElementById("nombre").textContent;

// Cambia ícono si ya está en favoritos
if (localStorage.getItem(artista)) {
    favBtn.innerHTML = '<i class="fa-solid fa-heart"></i> En favoritos';
}

favBtn.addEventListener('click', () => {
    if (!localStorage.getItem(artista)) {
        localStorage.setItem("art_" + artista, true);
        favBtn.innerHTML = '<i class="fa-solid fa-heart"></i> En favoritos';
        alert("¡Agregado a favoritos!");
    } else {
        localStorage.removeItem(artista);
        favBtn.innerHTML = '<i class="fa-regular fa-heart"></i> Agregar a favoritos';
        alert("Removido de favoritos.");
    }
});

console.log(localStorage)

// 1. Obtener el parámetro 'id' de la URL
const params = new URLSearchParams(window.location.search);
const id = params.get('id');

// 2. Verificar si hay ID
if (id) {
  // 3. Hacer la petición GET a la API
  fetch(`/api/artists?id=${id}`)
    .then(response => {
      if (!response.ok) throw new Error('No se pudo obtener el artista');
      return response.json();
    })
    .then(data => {
      const artista = data[0]; // Suponemos que API devuelve un array
      // 4. Mostrar datos en el HTML
      document.getElementById('nombre').textContent = artista.stage_name;
      document.getElementById('foto').src = artista.photo_url;
      document.getElementById('nombre-real').innerHTML = `Nombre real: <strong>${artista.real_name}</strong>`;
      document.getElementById('anio').innerHTML = `Año debut: <strong>${artista.debut_year}</strong>`;
      document.getElementById('oyentes').innerHTML = `Oyentes mensuales: <strong>${artista.monthly_listeners.toLocaleString('es-ES')}</strong>`;
    })
    .catch(err => {
      console.error(err);
      document.body.innerHTML = '<p>Error al cargar el artista.</p>';
    });

    //Info de las canciones
    fetch(`/api/songs?artist_id=${id}`)
    .then(response => {
      if (!response.ok) throw new Error('No se pudieron cargar las canciones');
      return response.json();
    })
    .then(songs => {
      const ul = document.getElementById('lista-canciones');

      if (songs.length === 0) {
        ul.innerHTML = '<li><p>No hay canciones disponibles.</p></li>';
        return;
      }

      songs.sort((a, b) => b.play_count - a.play_count); // ordena por más escuchadas

      songs.forEach(song => {
        const li = document.createElement('li');

        const a = document.createElement('a');
        a.href = `detalle_cancion.html?id=${song.id}`;

        const h3 = document.createElement('h4');
        h3.textContent = song.title;

        a.appendChild(h3);
        li.appendChild(a);
        ul.appendChild(li);
      });
    })
    .catch(err => {
      console.error(err);
      document.getElementById('lista-canciones').innerHTML = '<li><p>Error al cargar canciones.</p></li>';
    });


    //Info de las albumes
    fetch(`/api/albums?artist_id=${id}`)
    .then(response => {
      if (!response.ok) throw new Error('No se pudieron cargar los álbumes');
      return response.json();
    })
    .then(albums => {
      const ul = document.getElementById('lista-albums');

      if (albums.length === 0) {
        ul.innerHTML = '<li><p>No hay álbumes disponibles.</p></li>';
        return;
      }

      albums.forEach(album => {
        const li = document.createElement('li');
        const img = document.createElement('img');
        img.src = album.photo_url;

        const h3 = document.createElement('h4');
        h3.textContent = album.name;

        li.appendChild(img);
        li.appendChild(h3);
        ul.appendChild(li);
      });
    })
    .catch(err => {
      console.error(err);
      document.getElementById('lista-albums').innerHTML = '<li><p>Error al cargar álbumes.</p></li>';
    });
} else {
  document.body.innerHTML = '<p>Parámetro "id" no encontrado en la URL.</p>';
}
