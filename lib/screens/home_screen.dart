import 'package:flutter/material.dart';
import '../models/film.dart';
import 'film_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Film> films = [
    Film(
      id: 1,
      title: 'Inception',
      director: 'Christopher Nolan',
      year: 2010,
      description: 'A thief who steals corporate secrets through dream-sharing technology.',
      genre: 'Sci-Fi',
      rating: 8.8,
      imageUrl: 'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
    ),
    Film(
      id: 2,
      title: 'The Dark Knight',
      director: 'Christopher Nolan',
      year: 2008,
      description: 'Batman faces the Joker, a criminal mastermind who wants to plunge Gotham into anarchy.',
      genre: 'Action',
      rating: 9.0,
      imageUrl: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    ),
    Film(
      id: 3,
      title: 'Interstellar',
      director: 'Christopher Nolan',
      year: 2014,
      description: 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
      genre: 'Sci-Fi',
      rating: 8.6,
      imageUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    ),
    Film(
      id: 4,
      title: 'Pulp Fiction',
      director: 'Quentin Tarantino',
      year: 1994,
      description: 'The lives of two mob hitmen, a boxer, a gangster\'s wife intertwine in four tales of violence and redemption.',
      genre: 'Drama',
      rating: 8.9,
      imageUrl: 'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
    ),
    Film(
      id: 5,
      title: 'The Matrix',
      director: 'Lana Wachowski, Lilly Wachowski',
      year: 1999,
      description: 'A computer hacker learns from mysterious rebels about the true nature of his reality.',
      genre: 'Sci-Fi',
      rating: 8.7,
      imageUrl: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
    ),
    Film(
  id: 6,
  title: 'The Godfather',
  director: 'Francis Ford Coppola',
  year: 1972,
  description: 'The aging patriarch of an organized crime dynasty transfers control to his reluctant son.',
  genre: 'Drama',
  rating: 9.2,
  imageUrl: 'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsLeMEdzsURDj.jpg',
),
Film(
  id: 7,
  title: 'Forrest Gump',
  director: 'Robert Zemeckis',
  year: 1994,
  description: 'The presidencies of Kennedy and Johnson through the eyes of an Alabama man with an IQ of 75.',
  genre: 'Drama',
  rating: 8.8,
  imageUrl: 'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
),
Film(
  id: 8,
  title: 'The Shawshank Redemption',
  director: 'Frank Darabont',
  year: 1994,
  description: 'Two imprisoned men bond over a number of years, finding solace and eventual redemption.',
  genre: 'Drama',
  rating: 9.3,
  imageUrl: 'https://image.tmdb.org/t/p/w500/lyQBXzOQSuE59IsHyhrp0qIiPAz.jpg',
),
Film(
  id: 9,
  title: 'Gladiator',
  director: 'Ridley Scott',
  year: 2000,
  description: 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family.',
  genre: 'Action',
  rating: 8.5,
  imageUrl: 'https://image.tmdb.org/t/p/w500/ehGpAZi7F0QfEBSHxAGZ9FMo0hl.jpg',
),
Film(
  id: 10,
  title: 'Joker',
  director: 'Todd Phillips',
  year: 2019,
  description: 'A mentally troubled comedian embarks on a downward spiral that leads to a life of crime in Gotham City.',
  genre: 'Drama',
  rating: 8.4,
  imageUrl: 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
),
Film(
  id: 11,
  title: 'Parasite',
  director: 'Bong Joon-ho',
  year: 2019,
  description: 'Greed and class discrimination threaten the symbiotic relationship between the wealthy Park family and the destitute Kim clan.',
  genre: 'Thriller',
  rating: 8.5,
  imageUrl: 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
),
Film(
  id: 12,
  title: 'Dune',
  director: 'Denis Villeneuve',
  year: 2021,
  description: 'A noble family becomes embroiled in a war for control over the galaxy\'s most valuable asset.',
  genre: 'Sci-Fi',
  rating: 8.0,
  imageUrl: 'https://image.tmdb.org/t/p/w500/d5NXSklpcvzeBO6gAGEREkBahm2.jpg',
),
Film(
  id: 13,
  title: 'Oppenheimer',
  director: 'Christopher Nolan',
  year: 2023,
  description: 'The story of J. Robert Oppenheimer\'s role in the development of the atomic bomb during World War II.',
  genre: 'Drama',
  rating: 8.6,
  imageUrl: 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
),
Film(
  id: 14,
  title: 'Spider-Man: No Way Home',
  director: 'Jon Watts',
  year: 2021,
  description: 'With Spider-Man\'s identity now revealed, Peter asks Doctor Strange for help, which soon puts the world at risk.',
  genre: 'Action',
  rating: 8.2,
  imageUrl: 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
),
Film(
  id: 15,
  title: 'Avengers: Endgame',
  director: 'Anthony Russo, Joe Russo',
  year: 2019,
  description: 'After the devastating events of Infinity War, the Avengers assemble once more to reverse Thanos\'s actions.',
  genre: 'Action',
  rating: 8.4,
  imageUrl: 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
),
Film(
      id: 16,
      title: 'Gladiator',
      director: 'Ridley Scott',
      year: 2000,
      description: 'A former Roman general sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.',
      genre: 'Action',
      rating: 8.5,
      imageUrl: 'https://image.tmdb.org/t/p/w500/9O7gLzmreU0nGkIB6K3BsJbzvNv.jpg',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films populaires'),
        backgroundColor: Colors.deepPurple,
        elevation: 8.0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
        ),
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilmDetailsScreen(film: film),
                ),
              );
            },
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Stack(
                children: [
                  // Image affiche
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      film.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.deepPurple.withOpacity(0.2),
                          child: const Center(
                            child: Icon(
                              Icons.movie,
                              size: 50.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Overlay avec titre et note
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            film.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16.0,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                '${film.rating}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
