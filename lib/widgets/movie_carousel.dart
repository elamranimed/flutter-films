import 'package:flutter/material.dart';
import '../models/imdb_title.dart';
import 'movie_card.dart';
import 'shimmer_loading.dart';

class MovieCarousel extends StatelessWidget {
  final String title;
  final List<ImdbTitle> movies;
  final bool isLoading;

  const MovieCarousel({
    Key? key,
    required this.title,
    required this.movies,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading && movies.isEmpty) {
      return const SizedBox.shrink(); // Don't show empty carousels
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: isLoading
              ? _buildLoadingCarousel()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: movies[index],
                      heroPrefix: title.replaceAll(' ', '_'),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildLoadingCarousel() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(width: 130, height: 195),
              SizedBox(height: 8),
              ShimmerLoading(width: 100, height: 14),
              SizedBox(height: 4),
              ShimmerLoading(width: 40, height: 12),
            ],
          ),
        );
      },
    );
  }
}
