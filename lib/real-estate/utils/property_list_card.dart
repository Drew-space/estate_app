import 'package:estate_app/real-estate/pages/property_detail_screen.dart';
import 'package:estate_app/real-estate/provider/exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Horizontal list-style property card.
/// Used by both the Explore screen and the Favorites screen,
/// so the favorite toggle behaves identically everywhere.
class PropertyListCard extends ConsumerWidget {
  final Map<String, dynamic> house;

  const PropertyListCard({super.key, required this.house});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = List<String>.from(house["images"] ?? []);
    final coverImage = images.isNotEmpty ? images.first : "";
    final houseId = house["id"] as String;

    // ref.watch here means: if this specific house's favorite
    // status changes, ONLY this card rebuilds — not the whole list.
    final isFavorite = ref.watch(favoritesProvider).contains(houseId);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailScreen(house: house),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE with rating badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    coverImage,
                    height: 88,
                    width: 88,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 11),
                        const SizedBox(width: 2),
                        Text(
                          "${house["rating"] ?? 4.8}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            /// INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          house["title"] ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      /// HEART — plain Icon, not HugeIcon, as requested.
                      // Tapping this toggles the favorite for THIS house only.
                      GestureDetector(
                        onTap: () {
                          ref.read(favoritesProvider.notifier).toggle(houseId);
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                          size: 22,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    house["location"] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    house["price"] ?? "",
                    style: const TextStyle(
                      color: Color(0xff246BFD),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
