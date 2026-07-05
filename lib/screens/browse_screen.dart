import 'package:flutter/material.dart';
import '../models/imdb_title.dart';
import '../services/imdb_api_service.dart';
import '../widgets/movie_card.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final ImdbApiService _apiService = ImdbApiService();
  List<ImdbTitle> _movies = [];
  bool _isLoading = true;
  String _selectedGenre = 'Action';

  final List<String> _genres = [
    'Action', 'Adventure', 'Animation', 'Comedy', 'Crime', 
    'Documentary', 'Drama', 'Family', 'Fantasy', 'History',
    'Horror', 'Music', 'Mystery', 'Romance', 'Sci-Fi', 'Thriller'
  ];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() => _isLoading = true);
    try {
      final results = await _apiService.getTitles(
        genres: [_selectedGenre],
        sortBy: 'SORT_BY_POPULARITY',
        minVoteCount: 1000,
      );
      if (mounted) {
        setState(() {
          _movies = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
      print('Browse error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorer par genre'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Genre Chips horizontal scroll
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _genres.length,
              itemBuilder: (context, index) {
                final genre = _genres[index];
                final isSelected = genre == _selectedGenre;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected && _selectedGenre != genre) {
                        setState(() => _selectedGenre = genre);
                        _fetchMovies();
                      }
                    },
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _movies.isEmpty
                    ? const Center(child: Text('Aucun film trouvé.'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _movies.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: double.infinity,
                            child: MovieCard(
                              movie: _movies[index],
                              width: double.infinity,
                              heroPrefix: 'browse',
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
