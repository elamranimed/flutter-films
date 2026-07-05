class Film {
  final int id;
  final String title;
  final String director;
  final int year;
  final String description;
  final String genre;
  final double rating;
  final String imageUrl;

  Film({
    required this.id,
    required this.title,
    required this.director,
    required this.year,
    required this.description,
    required this.genre,
    required this.rating,
    required this.imageUrl,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'] as int,
      title: json['title'] as String,
      director: json['director'] as String,
      year: json['year'] as int,
      description: json['description'] as String,
      genre: json['genre'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'year': year,
      'description': description,
      'genre': genre,
      'rating': rating,
      'imageUrl': imageUrl,
    };
  }

  Film copyWith({
    int? id,
    String? title,
    String? director,
    int? year,
    String? description,
    String? genre,
    double? rating,
    String? imageUrl,
  }) {
    return Film(
      id: id ?? this.id,
      title: title ?? this.title,
      director: director ?? this.director,
      year: year ?? this.year,
      description: description ?? this.description,
      genre: genre ?? this.genre,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
