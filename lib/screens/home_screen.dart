import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';
import '../widgets/hero_banner.dart';
import '../widgets/movie_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extend body behind app bar so the hero image goes to the top
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'FILMS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white, // Always white on the hero image
          ),
        ),
        centerTitle: false,
      ),
      body: Consumer<MoviesProvider>(
        builder: (context, moviesProvider, child) {
          // Use the first popular movie as the hero, if available
          final featuredMovie = moviesProvider.popularMovies.isNotEmpty
              ? moviesProvider.popularMovies.first
              : null;

          // Remove the featured movie from the popular list for the carousel
          final popularCarousel = moviesProvider.popularMovies.isNotEmpty
              ? moviesProvider.popularMovies.skip(1).toList()
              : [];

          return RefreshIndicator(
            onRefresh: moviesProvider.refreshHomeData,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroBanner(
                    movie: featuredMovie,
                    isLoading: moviesProvider.isLoadingPopular,
                  ),
                  const SizedBox(height: 20),
                  MovieCarousel(
                    title: '🔥 Tendances actuelles',
                    movies: popularCarousel.cast(),
                    isLoading: moviesProvider.isLoadingPopular,
                  ),
                  const SizedBox(height: 10),
                  MovieCarousel(
                    title: '⭐ Les mieux notés',
                    movies: moviesProvider.topRatedMovies,
                    isLoading: moviesProvider.isLoadingTopRated,
                  ),
                  const SizedBox(height: 10),
                  MovieCarousel(
                    title: '📅 Récemment sortis',
                    movies: moviesProvider.recentMovies,
                    isLoading: moviesProvider.isLoadingRecent,
                  ),
                  const SizedBox(height: 40), // Bottom padding
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
