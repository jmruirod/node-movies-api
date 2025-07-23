CREATE TABLE movies(  
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    director VARCHAR(255) NOT NULL,
    duration INT NOT NULL,
    poster TEXT,
    rate DECIMAL(2, 1) UNSIGNED NOT NULL
);

CREATE TABLE genres(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE movie_genres(
    movie_id BINARY(16) REFERENCES movies(id),
    genre_id INT REFERENCES genres(id),
    PRIMARY KEY (movie_id, genre_id)
);

INSERT INTO genres (name) VALUES 
('Drama'),
('Action'),
('Crime'),
('Adventure'),
('Sci-Fi'),
('Romance');

INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES
(UUID_TO_BIN(UUID()), "Interstellar", 2014, "Christopher Nolan", 169, "https://m.media-amazon.com/images/I/91obuWzA3XL._AC_UF1000,1000_QL80_.jpg", 8.6 ),
(UUID_TO_BIN(UUID()), "The Dark Knight", 2008, "Christopher Nolan", 152, "https://i.ebayimg.com/images/g/yokAAOSw8w1YARbm/s-l1200.jpg", 9.0 ),
(UUID_TO_BIN(UUID()), "Inception", 2010, "Christopher Nolan", 148, "https://m.media-amazon.com/images/I/91Rc8cAmnAL._AC_UF1000,1000_QL80_.jpg", 8.8 ),
(UUID_TO_BIN(UUID()), "Pulp Fiction", 1994, "Quentin Tarantino", 154, "https://www.themoviedb.org/t/p/original/vQWk5YBFWF4bZaofAbv0tShwBvQ.jpg", 8.9 ),
(UUID_TO_BIN(UUID()), "The Shawshank Redemption", 1994, "Frank Darabont", 142, "https://i.ebayimg.com/images/g/4goAAOSwMyBe7hnQ/s-l1200.webp", 9.3 );

INSERT INTO movie_genres(movie_id, genre_id)
VALUES
    ((SELECT id FROM movies where title = 'Interstellar'), (SELECT id FROM genres where name = 'Adventure')),
    ((SELECT id FROM movies where title = 'Interstellar'), (SELECT id FROM genres where name = 'Drama')),
    ((SELECT id FROM movies where title = 'Interstellar'), (SELECT id FROM genres where name = 'Sci-Fi')),
    ((SELECT id FROM movies where title = 'The Dark Knight'), (SELECT id FROM genres where name = 'Action')),
    ((SELECT id FROM movies where title = 'The Dark Knight'), (SELECT id FROM genres where name = 'Crime')),
    ((SELECT id FROM movies where title = 'The Dark Knight'), (SELECT id FROM genres where name = 'Drama')),
    ((SELECT id FROM movies where title = 'Inception'), (SELECT id FROM genres where name = 'Action')),
    ((SELECT id FROM movies where title = 'Inception'), (SELECT id FROM genres where name = 'Adventure')),
    ((SELECT id FROM movies where title = 'Inception'), (SELECT id FROM genres where name = 'Sci-Fi')),
    ((SELECT id FROM movies where title = 'Pulp Fiction'), (SELECT id FROM genres where name = 'Crime')),
    ((SELECT id FROM movies where title = 'Pulp Fiction'), (SELECT id FROM genres where name = 'Drama')),
    ((SELECT id FROM movies where title = 'The Shawshank Redemption'), (SELECT id FROM genres where name = 'Drama'));

SELECT * from movies;