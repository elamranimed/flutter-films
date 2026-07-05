import 'imdb_title.dart';

class ImdbCredit {
  final ImdbTitle? title;
  final ImdbName? name;
  final String? category;
  final List<String> characters;
  final int? episodeCount;

  ImdbCredit({
    this.title,
    this.name,
    this.category,
    this.characters = const [],
    this.episodeCount,
  });

  factory ImdbCredit.fromJson(Map<String, dynamic> json) {
    return ImdbCredit(
      title: json['title'] != null ? ImdbTitle.fromJson(json['title']) : null,
      name: json['name'] != null ? ImdbName.fromJson(json['name']) : null,
      category: json['category'] as String?,
      characters: (json['characters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      episodeCount: json['episodeCount'] as int?,
    );
  }
}
