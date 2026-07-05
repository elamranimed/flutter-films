import 'package:flutter/foundation.dart';
import '../models/imdb_title.dart';
import '../services/imdb_api_service.dart';

class MoviesProvider extends ChangeNotifier {
  final ImdbApiService _apiService = ImdbApiService();

  List<ImdbTitle> _popularMovies = [];
  List<ImdbTitle> _topRatedMovies = [];
  List<ImdbTitle> _recentMovies = [];
  List<ImdbTitle> _searchResults = [];

  bool _isLoadingPopular = false;
  bool _isLoadingTopRated = false;
  bool _isLoadingRecent = false;
  bool _isSearching = false;

  String _error = '';
  String? _searchErrorMessage;

  List<ImdbTitle> get popularMovies => _popularMovies;
  List<ImdbTitle> get topRatedMovies => _topRatedMovies;
  List<ImdbTitle> get recentMovies => _recentMovies;
  List<ImdbTitle> get searchResults => _searchResults;

  bool get isLoadingPopular => _isLoadingPopular;
  bool get isLoadingTopRated => _isLoadingTopRated;
  bool get isLoadingRecent => _isLoadingRecent;
  bool get isSearching => _isSearching;

  String get error => _error;
  String? get searchErrorMessage => _searchErrorMessage;

  MoviesProvider() {
    // Initial fetch
    refreshHomeData();
  }

  Future<void> refreshHomeData() async {
    fetchPopularMovies();
    fetchTopRatedMovies();
    fetchRecentMovies();
  }

  Future<void> fetchPopularMovies() async {
    if (_popularMovies.isNotEmpty) return;
    _isLoadingPopular = true;
    notifyListeners();

    try {
      _popularMovies = await _apiService.getTitles(
        types: ['MOVIE'],
        sortBy: 'SORT_BY_POPULARITY',
        sortOrder: 'DESC',
      );
      _error = '';
    } catch (e) {
      _error = 'Failed to load popular movies: $e';
    } finally {
      _isLoadingPopular = false;
      notifyListeners();
    }
  }

  Future<void> fetchTopRatedMovies() async {
    if (_topRatedMovies.isNotEmpty) return;
    _isLoadingTopRated = true;
    notifyListeners();

    try {
      _topRatedMovies = await _apiService.getTitles(
        types: ['MOVIE'],
        sortBy: 'SORT_BY_USER_RATING',
        sortOrder: 'DESC',
        minVoteCount: 50000, // Ensure they are actually popular top rated
      );
    } catch (e) {
      // Handle error gracefully
      print('Error top rated: $e');
    } finally {
      _isLoadingTopRated = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecentMovies() async {
    if (_recentMovies.isNotEmpty) return;
    _isLoadingRecent = true;
    notifyListeners();

    try {
      _recentMovies = await _apiService.getTitles(
        types: ['MOVIE'],
        sortBy: 'SORT_BY_RELEASE_DATE',
        sortOrder: 'DESC',
        minVoteCount: 1000, // Make sure it's a known movie
      );
    } catch (e) {
      print('Error recent: $e');
    } finally {
      _isLoadingRecent = false;
      notifyListeners();
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _searchErrorMessage = null;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _searchErrorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _apiService.searchTitles(query);
    } catch (e) {
      print('Search error: $e');
      _searchResults = [];
      if (e.toString().contains('429') || e.toString().contains('Too many')) {
        _searchErrorMessage = 'Trop de requêtes (erreur 429). L\'API IMDb bloque temporairement la recherche. Veuillez réessayer plus tard.';
      } else {
        _searchErrorMessage = 'Une erreur s\'est produite lors de la recherche. Veuillez vérifier votre connexion.';
      }
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }
}
