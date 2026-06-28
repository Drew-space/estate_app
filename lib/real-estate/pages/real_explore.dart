import 'package:estate_app/real-estate/utils/real_explore_recommendation_grid.dart';
import 'package:estate_app/real-estate/utils/real_explore_search_bar.dart';
import 'package:estate_app/real-estate/utils/real_navbar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class RealExplore extends StatelessWidget {
  const RealExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return const PropertySearchScreen();
  }
}

/// MAIN SCREEN
class PropertySearchScreen extends StatelessWidget {
  const PropertySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RealNavbar(),
                          ),
                        );
                      },
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
                          "Search for Your Ideal Home",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    const NotificationIcon(),
                  ],
                ),

                const SizedBox(height: 20),

                /// SEARCH
                Row(children: [const Expanded(child: RealExploreSearchBar())]),

                const SizedBox(height: 20),

                /// GRID
                const RealExploreRecommendationGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// NOTIFICATION ICON (moved from file)
class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        color: const Color(0xffEEF2F6),
        borderRadius: BorderRadius.circular(50),
      ),
      child: HugeIcon(icon: HugeIcons.strokeRoundedNotification01),
    );
  }
}

/// GRID

/// HOUSE CARD

/// FILTER CHIP
class FilterChipWidget extends StatelessWidget {
  final String title;
  final bool selected;

  const FilterChipWidget({
    super.key,
    required this.title,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xff246BFD) : const Color(0xffEEF2F6),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
