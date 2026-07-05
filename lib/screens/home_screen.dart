import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/film_data.dart';
import '../models/film.dart';
import '../providers/favorites_provider.dart';
import 'film_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  List<Film> get _filteredFilms {
    if (_searchQuery.isEmpty) return filmData;
    final query = _searchQuery.toLowerCase();
    return filmData
        .where((film) =>
            film.title.toLowerCase().contains(query) ||
            film.director.toLowerCase().contains(query) ||
            film.genre.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films populaires'),
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher par titre, réalisateur ou genre...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Grille de films
          Expanded(
            child: _filteredFilms.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Aucun film trouvé',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemCount: _filteredFilms.length,
                    itemBuilder: (context, index) {
                      final film = _filteredFilms[index];
                      return _buildFilmCard(film);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilmCard(Film film) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isFavorite = favoritesProvider.isFavorite(film.id);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilmDetailsScreen(
                  film: film,
                  heroTag: 'home-film-${film.id}',
                ),
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
                // Image affiche avec Hero
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Hero(
                    tag: 'home-film-${film.id}',
                    child: Image.network(
                      film.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder:
                          (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color:
                              Colors.deepPurple.withValues(alpha: 0.1),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder:
                          (context, error, stackTrace) {
                        return Container(
                          color:
                              Colors.deepPurple.withValues(alpha: 0.2),
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
                ),
                // Bouton favori
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      favoritesProvider.toggleFavorite(film.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            isFavorite ? Colors.red : Colors.white,
                        size: 20,
                      ),
                    ),
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
                          Colors.black.withValues(alpha: 0.9),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
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
    );
  }
}
