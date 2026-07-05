import 'package:flutter/material.dart';
import '../models/imdb_credit.dart';
import '../utils/image_utils.dart';

class CastCard extends StatelessWidget {
  final ImdbCredit credit;

  const CastCard({Key? key, required this.credit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          // Circular Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[800],
            ),
            clipBehavior: Clip.antiAlias,
            child: credit.name?.primaryImage?.url != null
                ? Image.network(
                    ImageUtils.getSizedImageUrl(credit.name!.primaryImage!.url!, 200),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, color: Colors.grey, size: 40),
                  )
                : const Icon(Icons.person, color: Colors.grey, size: 40),
          ),
          const SizedBox(height: 8),
          // Name
          Text(
            credit.name?.displayName ?? 'Unknown',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Character
          if (credit.characters.isNotEmpty)
            Text(
              credit.characters.first,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
