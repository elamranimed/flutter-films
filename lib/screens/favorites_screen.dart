import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/film_data.dart';
import '../models/film.dart';
import '../providers/favorites_provider.dart';
import 'film_details.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes favoris'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteFilms = filmData
              .where((film) => favoritesProvider.isFavorite(film.id))
              .toList();

          if (favoriteFilms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80.0,
                    color: Colors.grey.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Aucun film favori',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Ajoutez des films à vos favoris depuis la page d\'accueil',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: favoriteFilms.length,
            itemBuilder: (context, index) {
              final film = favoriteFilms[index];
              return _buildFavoriteCard(context, film, favoritesProvider);
            },
          );
        },
      ),
    );
  }

  Widget _buildFavoriteCard(
    BuildContext context,
    Film film,
    FavoritesProvider favoritesProvider,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmDetailsScreen(film: film),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Affiche du film
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  film.imageUrl,
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 120,
                      color: Colors.deepPurple.withValues(alpha: 0.2),
                      child: const Icon(
                        Icons.movie,
                        color: Colors.deepPurple,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              // Informations du film
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      film.director,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          film.genre,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.deepPurple[300],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const Text('•',
                            style: TextStyle(color: Colors.grey)),
                        const SizedBox(width: 8.0),
                        Text(
                          '${film.year}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: Colors.amber, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text(
                          '${film.rating}/10',
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Bouton retirer des favoris
              IconButton(
                onPressed: () {
                  favoritesProvider.toggleFavorite(film.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('${film.title} retiré des favoris'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'Annuler',
                        onPressed: () {
                          favoritesProvider.toggleFavorite(film.id);
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.favorite, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
