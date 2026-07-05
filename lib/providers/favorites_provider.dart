import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favoriteIds = {};

  /// Whether a film is in the favorites list.
  bool isFavorite(int id) => _favoriteIds.contains(id);

  /// Number of favorite films.
  int get count => _favoriteIds.length;

  /// Unmodifiable view of all favorite IDs.
  Set<int> get favoriteIds => Set.unmodifiable(_favoriteIds);

  /// Toggle a film's favorite status.
  void toggleFavorite(int id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }
}
