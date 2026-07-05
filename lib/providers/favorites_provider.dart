import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  /// Whether a film is in the favorites list.
  bool isFavorite(String id) => _favoriteIds.contains(id);

  /// Number of favorite films.
  int get count => _favoriteIds.length;

  /// Unmodifiable view of all favorite IDs.
  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  /// Toggle a film's favorite status.
  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }
}
