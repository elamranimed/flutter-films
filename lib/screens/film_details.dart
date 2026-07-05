import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/imdb_title.dart';
import '../models/imdb_credit.dart';
import '../models/imdb_box_office.dart';
import '../providers/favorites_provider.dart';
import '../services/imdb_api_service.dart';
import '../utils/image_utils.dart';
import '../widgets/cast_card.dart';

class FilmDetailsScreen extends StatefulWidget {
  final ImdbTitle movie;
  final String? heroTag;

  const FilmDetailsScreen({
    Key? key,
    required this.movie,
    this.heroTag,
  }) : super(key: key);

  @override
  State<FilmDetailsScreen> createState() => _FilmDetailsScreenState();
}

class _FilmDetailsScreenState extends State<FilmDetailsScreen> {
  final ImdbApiService _apiService = ImdbApiService();
  ImdbTitle? _fullDetails;
  List<ImdbCredit>? _credits;
  ImdbBoxOffice? _boxOffice;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    if (widget.movie.id == null) return;

    try {
      final futures = await Future.wait([
        _apiService.getTitle(widget.movie.id!),
        _apiService.getTitleCredits(widget.movie.id!),
        _apiService.getTitleBoxOffice(widget.movie.id!),
      ]);

      if (mounted) {
        setState(() {
          _fullDetails = futures[0] as ImdbTitle;
          _credits = futures[1] as List<ImdbCredit>;
          _boxOffice = futures[2] as ImdbBoxOffice?;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      print('Error fetching details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use full details if loaded, otherwise fall back to the basic movie object
    final displayMovie = _fullDetails ?? widget.movie;
    final rating = displayMovie.rating?.aggregateRating ?? 0.0;
    
    // Attempt to parse runtime
    String runtimeStr = '';
    if (displayMovie.runtimeSeconds != null) {
      int minutes = displayMovie.runtimeSeconds! ~/ 60;
      int hours = minutes ~/ 60;
      int remainingMins = minutes % 60;
      runtimeStr = '${hours}h ${remainingMins}m';
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, displayMovie, rating, runtimeStr),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action Buttons (Play / Favorite)
                  _buildActionButtons(context),
                  const SizedBox(height: 30.0),

                  // Plot synopsis
                  const Text(
                    'Synopsis',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    displayMovie.plot ?? 'Aucun synopsis disponible.',
                    style: const TextStyle(fontSize: 16.0, height: 1.5),
                  ),
                  const SizedBox(height: 30.0),

                  // Cast & Crew
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_credits != null && _credits!.isNotEmpty) ...[
                    const Text(
                      'Casting',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15.0),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _credits!.where((c) => c.category == 'actor' || c.category == 'actress').length,
                        itemBuilder: (context, index) {
                          final actors = _credits!
                              .where((c) => c.category == 'actor' || c.category == 'actress')
                              .toList();
                          return CastCard(credit: actors[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],

                  // Directors
                  if (displayMovie.directors.isNotEmpty) ...[
                    const Text(
                      'Réalisation',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      displayMovie.directors.map((d) => d.displayName).join(', '),
                      style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 20.0),
                  ],

                  // Box Office
                  if (!_isLoading && _boxOffice != null) ...[
                    const Text(
                      'Box Office',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15.0),
                    _buildBoxOfficeCard(),
                    const SizedBox(height: 40.0),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, ImdbTitle displayMovie, double rating, String runtimeStr) {
    return SliverAppBar(
      expandedHeight: 400.0,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Hero Image
            if (widget.heroTag != null)
              Hero(
                tag: widget.heroTag!,
                child: displayMovie.primaryImage?.url != null
                    ? Image.network(
                        ImageUtils.getSizedImageUrl(displayMovie.primaryImage!.url!, 800),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]),
                      )
                    : Container(color: Colors.grey[900]),
              )
            else
              displayMovie.primaryImage?.url != null
                  ? Image.network(
                      ImageUtils.getSizedImageUrl(displayMovie.primaryImage!.url!, 800),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]),
                    )
                  : Container(color: Colors.grey[900]),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Title and Meta information
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayMovie.primaryTitle ?? '',
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (rating > 0) ...[
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '$rating/10',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                      ],
                      if (displayMovie.startYear != null) ...[
                        Text(
                          displayMovie.startYear.toString(),
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(width: 16),
                      ],
                      if (runtimeStr.isNotEmpty) ...[
                        Text(
                          runtimeStr,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ],
                  ),
                  if (displayMovie.genres.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      displayMovie.genres.join(' • '),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {}, // Fake play button
            icon: const Icon(Icons.play_arrow, size: 28),
            label: const Text('Lecture', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Consumer<FavoritesProvider>(
          builder: (context, provider, child) {
            final isFav = provider.isFavorite(widget.movie.id ?? '');
            return Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  if (widget.movie.id != null) {
                    provider.toggleFavorite(widget.movie.id!);
                  }
                },
                icon: Icon(
                  isFav ? Icons.check : Icons.add,
                  color: isFav ? Colors.green : null,
                ),
                label: Text(isFav ? 'Ma liste' : 'Ajouter', style: const TextStyle(fontSize: 16)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color: isFav ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBoxOfficeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          _buildBoxOfficeRow('Budget', _boxOffice!.productionBudget?.amount, _boxOffice!.productionBudget?.currency),
          const Divider(),
          _buildBoxOfficeRow('Lancement (WE)', _boxOffice!.openingWeekendGross?.gross?.amount, _boxOffice!.openingWeekendGross?.gross?.currency),
          const Divider(),
          _buildBoxOfficeRow('Recettes Mondiales', _boxOffice!.worldwideGross?.amount, _boxOffice!.worldwideGross?.currency),
        ],
      ),
    );
  }

  Widget _buildBoxOfficeRow(String label, String? amount, String? currency) {
    if (amount == null) return const SizedBox.shrink();
    // Format large numbers with commas if they are purely digits
    String formattedAmount = amount;
    if (RegExp(r'^\d+$').hasMatch(amount)) {
      final value = int.parse(amount);
      formattedAmount = value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            '${currency ?? '\$'} $formattedAmount',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
