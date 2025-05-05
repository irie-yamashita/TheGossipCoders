//Boton favorito
const favBtn = document.getElementById('favBtn');
const cancion = document.getElementById("titulo").textContent;

console.log(cancion)

// Cambia ícono si ya está en favoritos
if (localStorage.getItem(cancion)) {
    favBtn.innerHTML = '<i class="fa-solid fa-heart"></i> En favoritos';
}

favBtn.addEventListener('click', () => {
    if (!localStorage.getItem(cancion)) {
        localStorage.setItem("can_" + cancion, true);
        favBtn.innerHTML = '<i class="fa-solid fa-heart"></i> En favoritos';
        alert("¡Agregado a favoritos!");
    } else {
        localStorage.removeItem(cancion);
        favBtn.innerHTML = '<i class="fa-regular fa-heart"></i> Agregar a favoritos';
        alert("Removido de favoritos.");
    }
});

console.log(localStorage)


const params = new URLSearchParams(window.location.search);
const songId = params.get('id');

if (songId) {
  fetch(`/api/songs?id=${songId}`)
    .then(res => {
      if (!res.ok) throw new Error('No se pudo obtener la canción');
      return res.json();
    })
    .then(async ([song]) => {
      // Rellenar campos básicos
      document.getElementById('titulo').textContent = song.title || 'DEFAULT';
      document.getElementById('genero').textContent = song.genre || 'DEFAULT';
      document.getElementById('release-year').textContent = `${song.release_year || 'DEFAULT'}`;
      document.getElementById('historia').innerHTML = song.story
        ? `<p>${song.story}</p>`
        : '<p>DEFAULT</p>';

      document.getElementById('reproducciones').innerHTML = `Número de reproducciones: <strong>${song.play_count?.toLocaleString('es-ES') || 'DEFAULT'}</strong>`;

      // Obtener datos de artista
      const artistaLink = document.getElementById('link-artista');
      if (song.artist_id) {
        const artistaRes = await fetch(`/api/artists?id=${song.artist_id}`);
        const artista = await artistaRes.json();
        artistaLink.textContent = artista[0]?.stage_name || 'DEFAULT';
        artistaLink.href = `detalle_artistas.html?id=${song.artist_id}`;
      } else {
        artistaLink.textContent = 'DEFAULT';
        artistaLink.href = '#';
      }

      // Obtener datos del álbum
      if (song.album_id) {
        const albumRes = await fetch(`/api/albums?id=${song.album_id}`);
        const album = await albumRes.json();
        document.getElementById('album-nombre').textContent = `Álbum: ${album[0]?.name || 'DEFAULT'}`;
        document.getElementById('album-img').src = album[0]?.photo_url || 'img/default_album.png';
      } else {
        document.getElementById('album-nombre').textContent = 'Álbum: DEFAULT';
        document.getElementById('album-img').src = 'img/default_album.png';
      }

      const clipUrl = song.clip_url;

    if (clipUrl && clipUrl.includes('youtube.com') || clipUrl.includes('youtu.be')) {
    const videoId = extractYoutubeId(clipUrl);

    if (videoId) {
        const iframe = document.createElement('iframe');
        iframe.width = "560";
        iframe.height = "315";
        iframe.src = `https://www.youtube.com/embed/${videoId}`;
        iframe.title = "YouTube video player";
        iframe.frameBorder = "0";
        iframe.allow =
        "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share";
        iframe.allowFullscreen = true;

        document.getElementById('video-container').appendChild(iframe);
    }
    }

    })
    .catch(err => {
      console.error('Error al cargar la canción:', err);
      document.body.innerHTML = '<p>Error al cargar los detalles de la canción.</p>';
    });
} else {
  document.body.innerHTML = '<p>ID de canción no especificado en la URL.</p>';
}


function extractYoutubeId(url) {
  const regExp =
    /^.*(youtu\.be\/|v=|\/embed\/|shorts\/)([^#&?]*).*/;
  const match = url.match(regExp);
  return match && match[2].length === 11 ? match[2] : null;
}