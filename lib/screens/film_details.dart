import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/film.dart';
import '../providers/favorites_provider.dart';

class FilmDetailsScreen extends StatelessWidget {
  final Film film;
  final String? heroTag;

  const FilmDetailsScreen({
    Key? key,
    required this.film,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film.title),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final isFavorite = favoritesProvider.isFavorite(film.id);
              return IconButton(
                onPressed: () {
                  favoritesProvider.toggleFavorite(film.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? '${film.title} retiré des favoris'
                            : '${film.title} ajouté aux favoris!',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image affiche en grand avec Hero
            Container(
              width: double.infinity,
              height: 400,
              color: Colors.deepPurple.withValues(alpha: 0.1),
              child: heroTag != null
                  ? Hero(
                      tag: heroTag!,
                      child: _buildPosterImage(),
                    )
                  : _buildPosterImage(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carte titre et infos
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          film.title,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Année: ${film.year}',
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Genre: ${film.genre}',
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Réalisateur
                  const Text(
                    'Réalisateur',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    film.director,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 20.0),

                  // Note avec étoiles visuelles
                  const Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        final starValue = (index + 1) * 2;
                        if (film.rating >= starValue) {
                          return const Icon(Icons.star,
                              color: Colors.amber, size: 28.0);
                        } else if (film.rating >= starValue - 1) {
                          return const Icon(Icons.star_half,
                              color: Colors.amber, size: 28.0);
                        } else {
                          return const Icon(Icons.star_border,
                              color: Colors.amber, size: 28.0);
                        }
                      }),
                      const SizedBox(width: 8.0),
                      Text(
                        '${film.rating}/10',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    film.description,
                    style:
                        const TextStyle(fontSize: 16.0, height: 1.5),
                  ),
                  const SizedBox(height: 30.0),

                  // Bouton favori
                  Consumer<FavoritesProvider>(
                    builder: (context, favoritesProvider, child) {
                      final isFavorite =
                          favoritesProvider.isFavorite(film.id);
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            favoritesProvider
                                .toggleFavorite(film.id);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFavorite
                                      ? '${film.title} retiré des favoris'
                                      : '${film.title} ajouté aux favoris!',
                                ),
                                duration:
                                    const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: Text(
                            isFavorite
                                ? 'Retirer des favoris'
                                : 'Ajouter aux favoris',
                            style:
                                const TextStyle(fontSize: 16.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFavorite
                                ? Colors.red
                                : Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterImage() {
    return Image.network(
      film.imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.deepPurple.withValues(alpha: 0.1),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.deepPurple.withValues(alpha: 0.2),
          child: const Center(
            child: Icon(
              Icons.movie,
              size: 80.0,
              color: Colors.deepPurple,
            ),
          ),
        );
      },
    );
  }
}
