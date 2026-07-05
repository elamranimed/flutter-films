class ImdbImage {
  final String? url;
  final int? width;
  final int? height;
  final String? type;

  ImdbImage({this.url, this.width, this.height, this.type});

  factory ImdbImage.fromJson(Map<String, dynamic> json) {
    return ImdbImage(
      url: json['url'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      type: json['type'] as String?,
    );
  }
}

class ImdbRating {
  final double? aggregateRating;
  final int? voteCount;

  ImdbRating({this.aggregateRating, this.voteCount});

  factory ImdbRating.fromJson(Map<String, dynamic> json) {
    return ImdbRating(
      aggregateRating: (json['aggregateRating'] as num?)?.toDouble(),
      voteCount: json['voteCount'] as int?,
    );
  }
}

class ImdbName {
  final String? id;
  final String? displayName;
  final ImdbImage? primaryImage;

  ImdbName({this.id, this.displayName, this.primaryImage});

  factory ImdbName.fromJson(Map<String, dynamic> json) {
    return ImdbName(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      primaryImage: json['primaryImage'] != null
          ? ImdbImage.fromJson(json['primaryImage'])
          : null,
    );
  }
}

class ImdbTitle {
  final String? id;
  final String? type;
  final String? primaryTitle;
  final String? originalTitle;
  final ImdbImage? primaryImage;
  final int? startYear;
  final int? endYear;
  final int? runtimeSeconds;
  final List<String> genres;
  final ImdbRating? rating;
  final String? plot;
  final List<ImdbName> directors;
  final List<ImdbName> writers;
  final List<ImdbName> stars;

  ImdbTitle({
    this.id,
    this.type,
    this.primaryTitle,
    this.originalTitle,
    this.primaryImage,
    this.startYear,
    this.endYear,
    this.runtimeSeconds,
    this.genres = const [],
    this.rating,
    this.plot,
    this.directors = const [],
    this.writers = const [],
    this.stars = const [],
  });

  factory ImdbTitle.fromJson(Map<String, dynamic> json) {
    return ImdbTitle(
      id: json['id'] as String?,
      type: json['type'] as String?,
      primaryTitle: json['primaryTitle'] as String?,
      originalTitle: json['originalTitle'] as String?,
      primaryImage: json['primaryImage'] != null
          ? ImdbImage.fromJson(json['primaryImage'])
          : null,
      startYear: json['startYear'] as int?,
      endYear: json['endYear'] as int?,
      runtimeSeconds: json['runtimeSeconds'] as int?,
      genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      rating: json['rating'] != null ? ImdbRating.fromJson(json['rating']) : null,
      plot: json['plot'] as String?,
      directors: (json['directors'] as List<dynamic>?)
              ?.map((e) => ImdbName.fromJson(e))
              .toList() ??
          [],
      writers: (json['writers'] as List<dynamic>?)
              ?.map((e) => ImdbName.fromJson(e))
              .toList() ??
          [],
      stars: (json['stars'] as List<dynamic>?)
              ?.map((e) => ImdbName.fromJson(e))
              .toList() ??
          [],
    );
  }
}
