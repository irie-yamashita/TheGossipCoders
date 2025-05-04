
# Documentación API REST

Esta API permite interactuar con datos de **usuarios**, **artistas**, **álbumes**, **canciones** y **reproducciones** (**plays**).

---

## Endpoints

URL raíz: `api`

### 1. Obtener Usuarios
**Método:** `GET`  
**Ruta:** `/users`  

#### Descripción:  
Obtiene una lista de usuarios o un usuario específico si se proporciona un `id`.

#### Parámetros de Consulta:
- **`id`** *(opcional)*: ID del usuario.  
  **Ejemplo:** `/users?id=1`

#### Respuestas:
- **200 OK**: Devuelve los usuarios o el usuario solicitado.
- **404 Not Found**: Si no se encuentra el usuario.
- **500 Internal Server Error**: Si hay un error al realizar la consulta.

#### Ejemplo de URL:
```plaintext
GET /users?id=1
```

---

### 2. Obtener Artistas
**Método:** `GET`  
**Ruta:** `/artists`  

#### Descripción:  
Obtiene una lista de artistas o un artista específico si se proporciona un `id`. Se puede limitar el número de resultados o buscar por nombre del artista.

#### Parámetros de Consulta:
- **`id`** *(opcional)*: ID del artista.  
  **Ejemplo:** `/artists?id=1`
- **`limit`** *(opcional)*: Número máximo de artistas a devolver.  
  **Ejemplo:** `/artists?limit=5`
- **`name`** *(opcional)*: Nombre del artista (búsqueda insensible a mayúsculas).  
  **Ejemplo:** `/artists?name=metallica`

#### Respuestas:
- **200 OK**: Devuelve los artistas o el artista solicitado.
- **404 Not Found**: Si no se encuentra el artista.
- **500 Internal Server Error**: Si hay un error al realizar la consulta.

#### Ejemplo de URL:
```plaintext
GET /artists?id=1
GET /artists?limit=5
GET /artists?name=metallica
```

---

### 3. Obtener Álbumes
**Método:** `GET`  
**Ruta:** `/albums`  

#### Descripción:  
Obtiene una lista de álbumes o un álbum específico si se proporciona un `id`. También se puede buscar por nombre del álbum o limitar la cantidad de resultados.

#### Parámetros de Consulta:
- **`id`** *(opcional)*: ID del álbum.  
  **Ejemplo:** `/albums?id=10`
- **`limit`** *(opcional)*: Número máximo de álbumes a devolver.  
  **Ejemplo:** `/albums?limit=5`
- **`name`** *(opcional)*: Nombre del álbum (búsqueda insensible a mayúsculas).  
  **Ejemplo:** `/albums?name=thriller`

#### Respuestas:
- **200 OK**: Devuelve los álbumes o el álbum solicitado.
- **404 Not Found**: Si no se encuentra el álbum.
- **500 Internal Server Error**: Si hay un error al realizar la consulta.

#### Ejemplo de URL:
```plaintext
GET /albums?id=10
GET /albums?limit=5
GET /albums?name=thriller
```

---

### 4. Obtener Canciones
**Método:** `GET`  
**Ruta:** `/songs`  

#### Descripción:  
Obtiene una lista de canciones o una canción específica si se proporciona un `id`. Se puede buscar por el título de la canción o limitar el número de resultados.

#### Parámetros de Consulta:
- **`id`** *(opcional)*: ID de la canción.  
  **Ejemplo:** `/songs?id=15`
- **`limit`** *(opcional)*: Número máximo de canciones a devolver, ordenadas por número de reproducciones.  
  **Ejemplo:** `/songs?limit=5`
- **`title`** *(opcional)*: Título de la canción (búsqueda insensible a mayúsculas).  
  **Ejemplo:** `/songs?title=thriller`

#### Respuestas:
- **200 OK**: Devuelve las canciones o la canción solicitada.
- **404 Not Found**: Si no se encuentra la canción.
- **500 Internal Server Error**: Si hay un error al realizar la consulta.

#### Ejemplo de URL:
```plaintext
GET /songs?id=15
GET /songs?limit=5
GET /songs?title=thriller
```

---

### 5. Obtener Reproducciones (Plays)
**Método:** `GET`  
**Ruta:** `/plays`  

#### Descripción:  
Obtiene una lista de reproducciones o las reproducciones asociadas a un usuario específico si se proporciona un `user_id`.

#### Parámetros de Consulta:
- **`user_id`** *(opcional)*: ID del usuario cuyas reproducciones se desean obtener.  
  **Ejemplo:** `/plays?user_id=1`

#### Respuestas:
- **200 OK**: Devuelve las reproducciones o las reproducciones de un usuario específico.
- **404 Not Found**: Si no se encuentran las reproducciones.
- **500 Internal Server Error**: Si hay un error al realizar la consulta.

#### Ejemplo de URL:
```plaintext
GET /plays?user_id=1
```

---

### Códigos de Respuesta

- **200 OK**: La solicitud fue exitosa y se devuelve la respuesta esperada.
- **404 Not Found**: No se encontró el recurso solicitado.
- **500 Internal Server Error**: Error inesperado al procesar la solicitud.

---

### Ejemplos de Uso

#### Obtener todos los artistas:
**Solicitud:**
```plaintext
GET /artists
```

**Respuesta:**
```json
[
  {
    "id": 1,
    "stage_name": "Artist Name",
    "monthly_listeners": 5000
  },
  {
    "id": 2,
    "stage_name": "Another Artist",
    "monthly_listeners": 3000
  }
]
```

#### Obtener un álbum específico por nombre:
**Solicitud:**
```plaintext
GET /albums?name=Thriller
```

**Respuesta:**
```json
[
  {
    "id": 10,
    "name": "Thriller",
    "release_date": "1982-11-30"
  }
]
```

#### Obtener canciones ordenadas por número de reproducciones:
**Solicitud:**
```plaintext
GET /songs?limit=5
```

**Respuesta:**
```json
[
  {
    "id": 1,
    "title": "Song 1",
    "play_count": 10000
  },
  {
    "id": 2,
    "title": "Song 2",
    "play_count": 9000
  }
]
```

---

### Notas Importantes
- Se utilizan consultas SQL para obtener los datos desde la base de datos. 
- Los parámetros de consulta son opcionales y pueden ser combinados en una misma solicitud para personalizar los resultados.
- La búsqueda de texto (por `name` o `title`) es insensible a mayúsculas.

---
