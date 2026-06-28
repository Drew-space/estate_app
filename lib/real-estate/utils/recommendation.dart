import 'package:cached_network_image/cached_network_image.dart';
import 'package:estate_app/real-estate/pages/property_detail_screen.dart';
import 'package:estate_app/real-estate/pages/real_explore.dart';
import 'package:estate_app/real-estate/provider/exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recommendation extends ConsumerWidget {
  Recommendation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final houses = ref.watch(filteredHousesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Our Recommendation",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RealExplore()),
                );
              },
              child: const Text(
                "See All",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// Categories
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category;

              return GestureDetector(
                onTap: () {
                  ref.read(selectedCategoryProvider.notifier).state = category;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : const Color(0xffEEF2F6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        /// Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: houses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) {
            final house = houses[index];
            final images = List<String>.from(house["images"] ?? []);
            final coverImage = images.isNotEmpty ? images.first : "";
            final houseId = house["id"] as String;

            // watching favoritesProvider here means: when THIS house's
            // favorite status flips, only this card rebuilds.
            final isFavorite = ref.watch(favoritesProvider).contains(houseId);

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image — ONLY this part navigates to the detail page.
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PropertyDetailScreen(house: house),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: coverImage,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        ),

                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(16),
                        //   child: Image.network(
                        //     coverImage,
                        //     height: 150,
                        //     width: double.infinity,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    house["title"] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    house["location"] ?? "",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        house["price"] ?? "",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),

                      /// HEART — separate tap zone from the image above.
                      // Tapping ONLY toggles favorite, never navigates.
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
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
