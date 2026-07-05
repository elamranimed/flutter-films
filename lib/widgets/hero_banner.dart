import 'package:flutter/material.dart';
import '../models/imdb_title.dart';
import '../screens/film_details.dart';
import '../utils/image_utils.dart';
import 'shimmer_loading.dart';

class HeroBanner extends StatelessWidget {
  final ImdbTitle? movie;
  final bool isLoading;

  const HeroBanner({
    Key? key,
    this.movie,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading || movie == null) {
      return const ShimmerLoading(
        width: double.infinity,
        height: 500,
        borderRadius: 0,
      );
    }

    final rating = movie!.rating?.aggregateRating ?? 0.0;
    
    // Attempt to parse runtime
    String runtimeStr = '';
    if (movie!.runtimeSeconds != null) {
      int minutes = movie!.runtimeSeconds! ~/ 60;
      int hours = minutes ~/ 60;
      int remainingMins = minutes % 60;
      runtimeStr = '${hours}h ${remainingMins}m';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilmDetailsScreen(
              movie: movie!,
              heroTag: 'hero-${movie!.id}',
            ),
          ),
        );
      },
      child: Stack(
        children: [
          // Background Image
          SizedBox(
            width: double.infinity,
            height: 500,
            child: Hero(
              tag: 'hero-${movie!.id}',
              child: movie!.primaryImage?.url != null
                  ? Image.network(
                      ImageUtils.getSizedImageUrl(movie!.primaryImage!.url!, 800),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]),
                    )
                  : Container(color: Colors.grey[900]),
            ),
          ),
          // Gradient Overlay
          Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.8),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
                stops: const [0.0, 0.5, 0.8, 1.0],
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie!.primaryTitle ?? '',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (rating > 0) ...[
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    if (movie!.startYear != null) ...[
                      Text(
                        movie!.startYear.toString(),
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                    ],
                    if (runtimeStr.isNotEmpty) ...[
                      Text(
                        runtimeStr,
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ],
                ),
                if (movie!.genres.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    movie!.genres.join(' • '),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilmDetailsScreen(
                              movie: movie!,
                              heroTag: 'hero-${movie!.id}',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Plus d\'infos'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
