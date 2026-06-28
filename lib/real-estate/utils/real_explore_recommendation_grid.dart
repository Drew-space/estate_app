import 'package:estate_app/real-estate/pages/property_detail_screen.dart';
import 'package:estate_app/real-estate/provider/exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class RealExploreRecommendationGrid extends ConsumerWidget {
  const RealExploreRecommendationGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final houses = ref.watch(filteredHousesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Found ${houses.length} Apartments",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),

        const SizedBox(height: 20),
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
        const SizedBox(height: 24),

        GridView.builder(
          itemCount: houses.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 18,
            childAspectRatio: .68,
          ),
          itemBuilder: (context, index) {
            final house = houses[index];
            final images = List<String>.from(house["images"] ?? []);
            final coverImage = images.isNotEmpty ? images.first : "";

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PropertyDetailScreen(house: house),
                  ),
                );
              },
              child: HouseCard(
                image: coverImage,
                title: house["title"] ?? "",
                location: house["location"] ?? "",
                price: house["price"] ?? "",
              ),
            );
          },
        ),
      ],
    );
  }
}

class HouseCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String price;

  const HouseCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 14),
                      SizedBox(width: 4),
                      Text(
                        "4.8",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),

          const SizedBox(height: 4),

          Text(
            location,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xff246BFD),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              HugeIcon(icon: HugeIcons.strokeRoundedFavourite),
            ],
          ),
        ],
      ),
    );
  }
}
