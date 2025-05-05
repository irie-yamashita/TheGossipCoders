
-- Tabla artists (corrigiendo el tipo de dato para el id)
CREATE TABLE IF NOT EXISTS artists (
    id SERIAL PRIMARY KEY,  -- Usamos SERIAL para que se incremente automáticamente
    stage_name VARCHAR(100) NOT NULL,
    real_name VARCHAR(100),
    debut_year INT,
    monthly_listeners INT,
    photo_url TEXT
);


CREATE TABLE albums (
    id SERIAL,
    name VARCHAR(100) NOT NULL,
    release_date DATE,
    artist_id INT,
    photo_url TEXT,
    CONSTRAINT pk_albums PRIMARY KEY (id),
    CONSTRAINT fk_albums_artist FOREIGN KEY (artist_id)
        REFERENCES artists(id)
        ON DELETE CASCADE
);

CREATE TABLE songs (
    id SERIAL,
    title VARCHAR(100) NOT NULL,
    release_year INT,
    genre VARCHAR(50),
    play_count INT DEFAULT 0,
    album_id INT,
    artist_id INT,
    story TEXT,
    clip_url TEXT,
    CONSTRAINT pk_songs PRIMARY KEY (id),
    CONSTRAINT fk_songs_album FOREIGN KEY (album_id)
        REFERENCES albums(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_songs_artist FOREIGN KEY (artist_id)
        REFERENCES artists(id)
        ON DELETE CASCADE
);

CREATE TABLE users (
    id SERIAL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_users PRIMARY KEY (id)
);

CREATE TABLE plays (
    id SERIAL PRIMARY KEY,
    song_id INT NOT NULL,
    user_id INT,
    play_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_plays_song FOREIGN KEY (song_id)
        REFERENCES songs(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_plays_user FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
);


-- Insertar datos en la tabla artists
INSERT INTO artists (stage_name, real_name, debut_year, monthly_listeners, photo_url) VALUES
('Sabrina Carpenter', 'Sabrina Annlynn Carpenter', 2014, 35000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapers.com%2Fimages%2Fhd%2Fsabrina-carpenter-playful-pose-7zgid16uwzlup7aw.jpg&f=1&nofb=1&ipt=072941ae2f21d635f7661795b29c97d9c82ba7fc0511f9285a7c0e1c28387ec9'),
('Benson Boone', 'Benson James Boone', 2021, 50000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftalentrecap.com%2Fwp-content%2Fuploads%2F2023%2F05%2FOriginal_BensonBoone_KeyArt.jpg&f=1&nofb=1&ipt=91acb51325b2711fedcb6cee01d5cacb935bcb41974c3a808ae8885255aef2b4'),
('Billie Eilish', 'Billie Eilish Pirate Baird O''Connell', 2015, 70000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpm1.narvii.com%2F6707%2Fb50400e7496a1dc6284f78fa1b554ac994d4f94c_hq.jpg&f=1&nofb=1&ipt=334473276a77b9508f3579b5ecc492603539233b2f313446e2cd550c46dd453d'),
('Cris Mj', 'Cristopher Álvarez García', 2021, 15000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.lacuarta.com%2Fresizer%2FNu4tknW721UaRJEIaZNKNxDpNRc%3D%2F1200x630%2Fsmart%2Fcloudfront-us-east-1.images.arcpublishing.com%2Fcopesa%2FWWCFYZIL5NEXJLZYG7K2NDDDEY.jpg&f=1&nofb=1&ipt=1dbe24a7c968d1b1ebdb8f5f311df6bff45a1bb18f2293e1cc534b5257dc4f85'),
('Teddy Swims', 'Jaten Dimsdale', 2019, 49000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fis1-ssl.mzstatic.com%2Fimage%2Fthumb%2FMusic221%2Fv4%2Fcd%2F5d%2F64%2Fcd5d64c2-338b-00c9-52d6-578a0f19d826%2F054391245908.jpg%2F1200x1200bf-60.jpg&f=1&nofb=1&ipt=70ef25dc738eabcdece95677f35db3efae26ea63bcccac99838b84e020f566d0'),
('Djo', 'Joseph David Keery', 2019, 5000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpplx-res.cloudinary.com%2Fimage%2Ffetch%2Fs--ql01Ridz--%2Ft_limit%2Fhttps%3A%2F%2Fimagenes.elpais.com%2Fresizer%2Fv2%2FLBPED3TRAVCVLITJWNEWSSZ2FE.jpg%253Fauth%253D75ca32b485707cf06d521f39533ac141c0a06d15d24aac3d81afb9a42d8474cf%2526focal%253D1896%25252C970%2526height%253D1470%2526width%253D1960&f=1&nofb=1&ipt=9d7719671b95a0207989094340b5b74d655060231c4c46a065119743ea498184'),
('Hozier', 'Andrew John Hozier-Byrne', 2013, 47000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2Foriginals%2F3d%2F69%2F49%2F3d69499c8dacfaa627be799fc709b938.jpg&f=1&nofb=1&ipt=efaff07d40c6ed1ce1b338415b6d9183b921f9975470663087663d674937377c'),
('The Weeknd', 'Abel Makkonen Tesfaye', 2010, 118000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fdailymusicroll.s3.us-west-2.amazonaws.com%2Fwp-content%2Fuploads%2F2022%2F01%2F12170344%2F190711608_333733644789710_4451607971151844014_n-e1641987263612-1024x758.jpg&f=1&nofb=1&ipt=6349626d9b31141f192d0deeb36043dbe37d32ee303d9353ab3b5b4ab15a3f6d'),
('JENNIE', 'Kim Jennie', 2016, 20000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2F736x%2F33%2F30%2Faf%2F3330af83884c942622700b1507e83f4d.jpg&f=1&nofb=1&ipt=0583bfb5715755d7bcaa80fabed3b13dfa579de83dc43243c07b3ecbb1125362'),
('Lily-Rose Depp', 'Lily-Rose Melody Depp', 2014, 1000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.fashiongonerogue.com%2Fwp-content%2Fuploads%2F2018%2F06%2FLily-Rose-Depp-Vogue-Cover-Photoshoot02.jpg&f=1&nofb=1&ipt=6f765f076c4b6f39f78ec3f48cdb345c7e7c4d3ed6b5ab588ac4881ffc7db7a2'),
('Taylor Swift', 'Taylor Alison Swift', 2006, 90000000, 'https://cdn-3.expansion.mx/dims4/default/f4fa201/2147483647/strip/true/crop/3046x3600+0+0/resize/1200x1418!/format/webp/quality/60/?url=https%3A%2F%2Fcdn-3.expansion.mx%2F8d%2Fb6%2F71cc65034ac5ade257ced6b04a97%2F10049491gf.jpg'),
('Bruno Mars', 'Peter Gene Hernandez', 2010, 150000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fratedrnb.com%2Fcdn%2F2022%2F11%2Fbruno-mars-1140x1140.jpg&f=1&nofb=1&ipt=ad8e6516104ae8411c8f352d4962fc35a93e745314045cb619f0163b3b2afe51'),
('Lady Gaga', 'Stefani Joanne Angelina Germanotta', 2008, 123000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage6.uhdpaper.com%2Fwallpaper-hd%2Flady-gaga-photoshoot-uhdpaper.com-hd-6.2462.jpg&f=1&nofb=1&ipt=32e432035678cf656a60d0a41de944b6566ce55a71668c67a515e99f3295b283'),
('Shaboozey', 'Collins Obinna Chibueze', 2018, 8000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Flastfm.freetls.fastly.net%2Fi%2Fu%2Far0%2F010f120016533a35889887cc676f1b41.jpg&f=1&nofb=1&ipt=d2f0fcaeb7d5b37b1d64a4bcab5814b34bb0d72132dfa5f8492e946554490ca5'),
('Post Malone', 'Austin Richard Post', 2015, 60000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Flastfm.freetls.fastly.net%2Fi%2Fu%2Far0%2F42965d97b9389125cb96e5024d2a1459.jpg&f=1&nofb=1&ipt=9c2ff3106d8f6c52ee8a8c942e68f40f83fd0839ae640cc1182e4ed58120595c'),
('Morgan Wallen', 'Morgan Cole Wallen', 2014, 35000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fca-times.brightspotcdn.com%2Fdims4%2Fdefault%2F59f63db%2F2147483647%2Fstrip%2Ftrue%2Fcrop%2F6600x9354%2B0%2B0%2Fresize%2F840x1191!%2Fquality%2F90%2F%3Furl%3Dhttps%3A%252F%252Fcalifornia-times-brightspot.s3.amazonaws.com%252F7b%252F5f%252Fc3bc12904b42bb5bf7bca77f9a6e%252Fmorganwallen.jpg&f=1&nofb=1&ipt=492563bf629c8923f45ef94383c8240a3b823a0de7b96caf0721681711e6fb4e'),
('Tommy Richman', 'Nombre Real Desconocido', 2023, 3000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.mystateline.com%2Fwp-content%2Fuploads%2Fsites%2F17%2F2024%2F11%2F6724f57c8dd436.10814311.jpeg%3Fw%3D1752%26h%3D986%26crop%3D1&f=1&nofb=1&ipt=df664f7f7e8a651f4696403f545adec683d620bd71cb60e2296d8550b07fdb7c'),
('Kendrick Lamar', 'Kendrick Lamar Duckworth', 2010, 40000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn.dnaindia.com%2Fsites%2Fdefault%2Ffiles%2F2018%2F04%2F17%2F672869-kendrick-lamar-reuters.jpg&f=1&nofb=1&ipt=b5c3ee1c41583c31bc95bc18c2c4101bc7460655beaefbcbb91611e6f184624c'),
('Zach Bryan', 'Zachary Lane Bryan', 2016, 16000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fen%2F6%2F69%2FZach_Bryan_2021.jpg&f=1&nofb=1&ipt=9bda73a9e78fe3ca99acaf12683ad10ccda56e3a30d9cfc30197e8f3a16e14a5'),
('Olivia Rodrigo', 'Olivia Isabel Rodrigo', 2021, 110000000, 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQZ-gIXIrHPlQ_yrmcSqbcvvrQP1iE5eTAMB605ZTgR4cWRYPlDTW4aMcZ6reHXBJYoaMC5f2jVJ6zoCk_BPLT6Aw'),
('Ximena Sariñana', 'Ximena Sariñana Rivera', 2008, 3000000, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.laverdadnoticias.com%2Fassets%2Fimg%2F2022%2F05%2F24%2Fximena-sarinana-1684908131647.jpg&f=1&nofb=1&ipt=c3a25de6d3dfc2d3b3de4a9ebf7716a52e907f8a2c32b91b1cc53fae2b7a7f9d');

INSERT INTO albums (name, release_date, artist_id, photo_url) VALUES
( 'Espresso (Single)', '2024-04-12', 1, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fsnworksceo.imgix.net%2Fnjs%2Ff8e21eee-ecc3-4e37-bc87-599a64742660.sized-1000x1000.jpeg%3Fw%3D1000&f=1&nofb=1&ipt=3e304874c00d8fde5433ad11c47e9a959097a7c1b85db96956e0a84f053ba7a0'),
( 'Fireworks & Rollerblades', '2024-04-05', 2, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fis1-ssl.mzstatic.com%2Fimage%2Fthumb%2FMusic211%2Fv4%2Fa5%2Fc1%2F9c%2Fa5c19c62-d641-93b4-2800-e74778569f5f%2F093624852483.jpg%2F1200x1200bf-60.jpg&f=1&nofb=1&ipt=150f848ee783997ec56b346bafa167ca7f34253fa8610f38516bb51c870a240d'),
( 'Hit Me Hard and Soft', '2024-05-17', 3, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.discogs.com%2F_jPK58D2xn6RtWkG06TKFUl5a7JkRUnUfVcB5abklUc%2Frs%3Afit%2Fg%3Asm%2Fq%3A90%2Fh%3A530%2Fw%3A600%2FczM6Ly9kaXNjb2dz%2FLWRhdGFiYXNlLWlt%2FYWdlcy9SLTMxNDEz%2FMTI1LTE3MjQwNTIz%2FNDQtMjczOC5qcGVn.jpeg&f=1&nofb=1&ipt=67b64d1c9ea000d430265b9d7c01a636ee21b751135ff9ace3342e6dde988700'),
( 'Gata Only (Single)', '2024-01-15', 4, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fis1-ssl.mzstatic.com%2Fimage%2Fthumb%2FMusic116%2Fv4%2Fca%2F4e%2F0f%2Fca4e0f11-2cbc-7aec-b2e4-53f5fac7cb0e%2F198309012715-copy-6dfc57c0.png%2F1200x1200bf-60.jpg&f=1&nofb=1&ipt=a832db9b86b00c9c448f5e8196e91d215025a62661b27af1e077312e734ab997'),
( 'I''ve Tried Everything But Therapy (Part 1)', '2023-09-15', 6, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.musicmaniarecords.be%2Fmedia%2Fcoverart-big%2F209176-ive-tried-everything-but-therapy-part-1.jpg&f=1&nofb=1&ipt=35a31f451e1987e20e31bdb40156b68d2c814f1c978b9405208f4370f811aefe'),
( 'DECIDE', '2022-09-16', 7, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fthemontclarion.org%2Fwp-content%2Fuploads%2F2022%2F10%2FIMG_6923.jpg&f=1&nofb=1&ipt=c3f94d9af29f38488f4439bc5f2a2dbc9c0f20f356bbee171649b2ff1324eb35'),
( 'Unreal Unearth', '2023-08-18', 8, 'https://m.media-amazon.com/images/I/81VulClq75L.jpg' ),
( 'The Idol Episode 4 (Music from the HBO Original Series)', '2023-06-23', 8, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fis1-ssl.mzstatic.com%2Fimage%2Fthumb%2FMusic116%2Fv4%2Fdb%2F28%2Fe7%2Fdb28e7c3-f53a-76c8-eaa4-d92a22e4f160%2F23UMGIM72115.rgb.jpg%2F1200x1200bf-60.jpg&f=1&nofb=1&ipt=b1af7e56394bb21ae2352b524b92913dc37b5a09d23743c53b2509afd620dd7c' ),
( 'Lover', '2019-08-23', 11, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fsuave.hn%2Fwp-content%2Fuploads%2F2019%2F08%2FAGAEH-1068x1068.jpg&f=1&nofb=1&ipt=a43d60e1f6db3a2f507c458e8ab9762d8edf2324dec6066e1d57fb9d281202d5'),
( 'Die With A Smile (Single)', '2024-02-01', 13, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.scdn.co%2Fimage%2Fab67616d0000b27335b56028ff1b13347a8aa5b6&f=1&nofb=1&ipt=b5ad3a3c006db044bc4d9da1b67c1c7cdf96408285de85083125d1549873ecfe' ),
( 'A Bar Song (Tipsy) (Single)', '2024-03-22', 15 , 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/72/1c/92/721c9211-2be5-4614-2ca3-28d55b0b5d88/197342837156_cover.jpg/600x600bf-60.jpg'),
( 'I Had Some Help (Single)', '2024-05-10', 16, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fe.snmc.io%2Fi%2F600%2Fs%2Fc1c007be7614500aade6327daec5d9c3%2F12342420%2Fgoldfinger-and-less-than-jake-i-had-some-help-Cover-Art.jpg&f=1&nofb=1&ipt=00a32bd8485dcdcdf393eddfdc6943b37f526e7904bb98028c70118f4e63b399'),
( 'Million Dollar Baby (Single)', '2024-04-22', 18 , 'https://upload.wikimedia.org/wikipedia/en/b/b5/Tommy_Richman_-_Million_Dollar_Baby.png'),
( 'Not Like Us (Single)', '2024-04-30', 19 , 'https://i.discogs.com/JPk6Q3amElDmVhOUfm7QXKEGnisfD1irN-qy-fqAwZ4/rs:fit/g:sm/q:40/h:300/w:300/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTMwNTg5/MDUxLTE3MTQ4ODMx/MTYtMjc2Mi5qcGVn.jpeg'),
( 'Zach Bryan (Deluxe)', '2023-08-25', 20 , 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fis1-ssl.mzstatic.com%2Fimage%2Fthumb%2FMusic116%2Fv4%2Fce%2F36%2F7f%2Fce367f3d-2a4f-46ee-1434-e3fbb52f1fc8%2F093624849797.jpg%2F1200x1200bf-60.jpg&f=1&nofb=1&ipt=6b51c88c9b100f0bf3958af09e483ff23ab3946e14279a7e29f51c86bdf2d49e'),
( 'Stick Season (We''ll All Be Here Forever)', '2023-06-09', 22, 'https://m.media-amazon.com/images/I/8112ZXxJSPL._UF894,1000_QL80_.jpg' ),
( 'Think Later', '2023-12-08', 23 , 'https://i.discogs.com/9epVWFh9DjHoIwoEwcPxbi4CD6qdPewJ4v3Wd--Otrc/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTI5ODA5/NzA1LTE3MDgxMjA5/OTUtNjUwOS5qcGVn.jpeg' ),
( 'We Don''t Trust You', '2024-03-22', 24 , 'https://m.media-amazon.com/images/I/71UvwTbl8bL._UF894,1000_QL80_.jpg'),
( 'Please Please Please (Single)', '2024-05-01', 1, 'https://i.scdn.co/image/ab67616d0000b2735da6f1d18ec09a6b6529d0fc'),
( 'Scarlet', '2023-09-22', 26 , 'https://cdn-images.dzcdn.net/images/cover/aea5d295972a673a994d88a82fb8e83c/0x1900-000000-80-0-0.jpg'),
( 'The Rise and Fall of a Midwest Princess', '2023-09-22', 27, 'https://m.media-amazon.com/images/I/51Z5NqkmzQL._UXNaN_FMjpg_QL85_.jpg'),
( 'Saturn (Single)', '2024-03-01', 28,'https://i.scdn.co/image/ab67616d0000b273d70916ee9e40c90380ba5f07' ),
( 'The Tortured Poets Department', '2024-04-19', 12 , 'https://m.media-amazon.com/images/I/71oYcOZ904L._UF894,1000_QL80_.jpg'),
( 'Water (Single)', '2023-07-28', 29 , 'https://i.scdn.co/image/ab67616d00001e02127e3f6eff5b738bea5ceda3'),
( 'Feather (Single)', '2024-01-05', 1 , 'https://i.discogs.com/4-9gXhNp93J26231vRPihPfsWblbITw4FpYR20wJjLE/rs:fit/g:sm/q:40/h:300/w:300/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTI5MTEw/MDQyLTE3MDI0OTgz/MjctMzU2Ny5qcGVn.jpeg'),
( 'Eternal Sunshine', '2024-03-08', 30, 'https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/34/fe/a1/34fea184-6d20-3f50-b4ce-5e1501c1c5ab/24UMGIM00198.rgb.jpg/600x600bf-60.jpg' ),
( 'Endless Summer Vacation', '2023-03-10', 31, 'https://images-eu.ssl-images-amazon.com/images/I/519DpQeHU5L._AC_UL210_SR210,210_.jpg'),
( 'La Vida Es Una', '2023-03-03', 32 , 'https://i.scdn.co/image/ab67616d0000b2730656d5ce813ca3cc4b677e05');


-- CANCIONES
INSERT INTO songs (title, release_year, genre, play_count, album_id, artist_id, story, clip_url)
VALUES
-- 1
('Espresso', 2024, 'Pop', 1800000000, 1, 1, 'Sabrina Carpenter lanza un himno pop que captura la esencia del verano.', 'https://youtu.be/eVli-tstM5E?si=hMKad9ILrsYtSQ0v'),
-- 2
('Beautiful Things', 2024, 'Pop Rock', 1700000000, 2, 2, 'Benson Boone emociona con una balada poderosa sobre la belleza de la vida.', 'https://youtu.be/Oa_RSwwpPaA?feature=shared'),
-- 3
('BIRDS OF A FEATHER', 2024, 'Alternative', 1600000000, 3, 3, 'Billie Eilish explora nuevas texturas sonoras en este tema introspectivo.', 'https://youtu.be/V9PVRfjEBTI?feature=shared'),
-- 4
('Gata Only', 2024, 'Reggaetón', 1500000000, 4, 4, 'FloyyMenor y Cris Mj presentan un éxito urbano que domina las pistas de baile.', 'https://youtu.be/-r687V8yqKY?feature=shared'),
-- 5
('Lose Control', 2024, 'Soul', 1400000000, 5, 6, 'Teddy Swims fusiona soul y pop en una canción que invita a dejarse llevar.', 'https://youtu.be/GZ3zL7kT6_c?feature=shared'),
-- 6
('End of Beginning', 2024, 'Indie Rock', 1300000000, 6, 7, 'Djo ofrece una reflexión sonora sobre los nuevos comienzos.', 'https://youtu.be/xy3AcmW0lrQ?si=2LqRlOPkPhFs4w1q'),
-- 7
('Too Sweet', 2024, 'Folk Rock', 1200000000, 7, 8, 'Hozier regresa con una melodía dulce y letras poéticas.', 'https://youtu.be/NTpbbQUBbuo?si=l3aUp8vm8CqoDRFV'),
-- 8
('One Of The Girls', 2024, 'R&B', 1100000000, 8, 9, 'The Weeknd colabora con JENNIE y Lily Rose Depp en una pista sensual.', 'https://youtu.be/Mx92lTYxrJQ?feature=shared'),
-- 9
('Cruel Summer', 2024, 'Pop', 1000000000, 9, 11, 'Taylor Swift revive un clásico con una nueva energía.', 'https://youtu.be/ic8j13piAhQ?si=qfJRv5hwQimwRoDE'),
-- 10
('Die With A Smile', 2024, 'Pop', 900000000, 10, 13, 'Bruno Mars y Lady Gaga unen fuerzas en una canción vibrante.', 'https://youtu.be/kPa7bsKwL-c?feature=shared'),
-- 11
('A Bar Song (Tipsy)', 2024, 'Country Rap', 850000000, 11, 15, 'Shaboozey mezcla géneros en un tema pegajoso.', 'https://youtu.be/t7bQwwqW-Hc?si=jXzrj93pKonmgC_e'),
-- 12
('I Had Some Help', 2024, 'Country Pop', 800000000, 12, 16, 'Post Malone y Morgan Wallen colaboran en una balada emotiva.', 'https://youtu.be/4QIZE708gJ4?si=1P5-okszYq-8jLPz'),
-- 13
('Million Dollar Baby', 2024, 'Hip-Hop', 750000000, 13, 18, 'Tommy Richman presenta un tema lleno de energía y estilo.', 'https://youtu.be/Zf1d8SGuxfs?si=RVkCnISsMb084BRS'),
-- 14
('Not Like Us', 2024, 'Rap', 700000000, 14, 19, 'Kendrick Lamar lanza una crítica social con su estilo característico.', 'https://youtu.be/H58vbez_m4E?si=0-Pk89RDVEobks4a'),
-- 15
('I Remember Everything', 2024, 'Country', 650000000, 15, 20, 'Zach Bryan y Kacey Musgraves evocan nostalgia en esta colaboración.', 'https://youtu.be/ZVVvJjwzl6c?feature=shared'),
-- 16
('Stick Season', 2024, 'Indie Folk', 600000000, 16, 22, 'Noah Kahan captura la esencia del otoño en esta canción.', 'https://youtu.be/iWG6apzIWAk?feature=shared'),
-- 17
('Greedy', 2024, 'Pop', 550000000, 17, 23, 'Tate McRae presenta un tema audaz y contagioso.', 'https://youtu.be/To4SWGZkEPk?feature=shared'),
-- 18
('Like That', 2024, 'Hip-Hop', 500000000, 18, 24, 'Future, Metro Boomin y Kendrick Lamar se unen en una pista potente.', 'https://youtu.be/N9bKBAA22Go?feature=shared'),
-- 19
('Please Please Please', 2024, 'Pop', 450000000, 19, 1, 'Sabrina Carpenter lanza otro éxito con este tema melódico.', 'https://youtu.be/cF1Na4AIecM?feature=shared'),
-- 20
('Agora Hills', 2024, 'Hip-Hop', 400000000, 20, 26, 'Doja Cat explora nuevos sonidos en esta canción innovadora.', 'https://youtu.be/0c66ksfigtU?feature=shared'),
-- 21
('Good Luck, Babe!', 2024, 'Pop', 350000000, 21, 27, 'Chappell Roan ofrece un mensaje de empoderamiento en este tema.', 'https://youtu.be/1RKqOmSkGgM?feature=shared'),
-- 22
('Saturn', 2024, 'R&B', 300000000, 22, 28, 'SZA canta sobre crecimiento personal y transformación.', 'https://youtu.be/V2G8ESoDXm8?feature=shared'),
-- 23
('Paint the Town Red', 2024, 'Hip-Hop', 250000000, 23, 26, 'Doja Cat regresa con un tema vibrante y atrevido.', 'https://youtu.be/m4_9TFeMfJE?feature=shared'),
-- 24
('Fortnight', 2024, 'Pop', 200000000, 24, 11, 'Taylor Swift y Post Malone colaboran en una balada conmovedora.', 'https://youtu.be/q3zqJs7JUCQ?feature=shared'),
-- 25
('Water', 2024, 'Afrobeat', 150000000, 25, 29, 'Tyla presenta un ritmo refrescante y bailable.', 'https://youtu.be/XoiOOiuH8iI?feature=shared'),
-- 26
('Feather', 2024, 'Pop', 100000000, 26, 1, 'Sabrina Carpenter muestra su versatilidad en este tema suave.', 'https://youtu.be/kLbn61Z4LDI?feature=shared'),
-- 27
('We Can''t Be Friends (Wait for Your Love)', 2024, 'Pop', 95000000, 27, 30, 'Ariana Grande canta sobre relaciones complicadas.', 'https://youtu.be/KNtJGQkC-WI?feature=shared'),
-- 28
('Vampire',2024, 'Pop', 90000000, 28, 34, 'Olivia Rodrigo lanza un tema emocional y poderoso.', 'https://youtu.be/RlPNh_PBZb4?feature=shared'),
-- 29
('Cruel Summer (Taylor''s Version)', 2024, 'Pop', 85000000, 8, 11, 'Taylor Swift lanza una nueva versión de su éxito.', 'https://youtu.be/ic8j13piAhQ?si=evPJKrtfEdJ8J0T9');

-- USUARIOS
INSERT INTO users (name, email, password, registration_date) VALUES
('Ana Gómez', 'ana@example.com', 'hashedpwd1', '2023-01-01'),
('Carlos Ruiz', 'carlos@example.com', 'hashedpwd2', '2023-01-05'),
('Laura Méndez', 'laura@example.com', 'hashedpwd3', '2023-02-10'),
('Miguel Torres', 'miguel@example.com', 'hashedpwd4', '2023-03-15'),
('Sofía León', 'sofia@example.com', 'hashedpwd5', '2023-03-20');


-- REPRODUCCIONES
INSERT INTO plays (song_id, user_id, play_date) VALUES
(1, 1, '2023-04-01'),
(2, 1, '2023-04-02'),
(3, 2, '2023-04-02'),
(4, 3, '2023-04-03'),
(5, 4, '2023-04-04');
