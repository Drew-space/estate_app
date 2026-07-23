// import 'package:flutter/material.dart';

// class  extends StatelessWidget {
//   const RealFavourite({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(backgroundColor: Colors.white);
//   }
// }

import 'package:estate_app/real-estate/provider/exam.dart';
import 'package:estate_app/real-estate/utils/property_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RealFavourite extends ConsumerWidget {
  const RealFavourite({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final favoriteHouses = ref.watch(favoriteHousesProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP BAR — just back arrow + "Favorites", no notification icon
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xffEEF2F6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Favorites",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 42),
                ],
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
                        ref.read(selectedCategoryProvider.notifier).state =
                            category;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xff246BFD)
                              : const Color(0xffEEF2F6),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          category,
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

              /// LIST or EMPTY STATE
              Expanded(
                child: favoriteHouses.isEmpty
                    ? const _EmptyFavorites()
                    : ListView.builder(
                        itemCount: favoriteHouses.length,
                        itemBuilder: (context, index) {
                          return PropertyListCard(house: favoriteHouses[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_border, size: 56, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            "No favorites yet",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
