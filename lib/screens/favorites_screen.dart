import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/imdb_title.dart';
import '../providers/favorites_provider.dart';
import '../services/imdb_api_service.dart';
import '../widgets/movie_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ImdbApiService _apiService = ImdbApiService();
  List<ImdbTitle> _favoriteMovies = [];
  bool _isLoading = false;
  Set<String> _lastFetchedIds = {};

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-fetch if favorites changed
    final currentFavIds = Provider.of<FavoritesProvider>(context).favoriteIds;
    if (_lastFetchedIds.length != currentFavIds.length || !_lastFetchedIds.containsAll(currentFavIds)) {
      _fetchFavorites();
    }
  }

  Future<void> _fetchFavorites() async {
    final favIds = Provider.of<FavoritesProvider>(context, listen: false).favoriteIds;
    if (favIds.isEmpty) {
      if (mounted) {
        setState(() {
          _favoriteMovies = [];
          _lastFetchedIds = favIds;
        });
      }
      return;
    }

    setState(() => _isLoading = true);
    try {
      final futures = favIds.map((id) => _apiService.getTitle(id));
      final results = await Future.wait(futures);

      if (mounted) {
        setState(() {
          _favoriteMovies = results;
          _lastFetchedIds = favIds;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching favorites: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Favoris'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteMovies.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Aucun favori pour le moment.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _favoriteMovies.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      child: MovieCard(
                        movie: _favoriteMovies[index],
                        width: double.infinity,
                        heroPrefix: 'fav',
                      ),
                    );
                  },
                ),
    );
  }
}
