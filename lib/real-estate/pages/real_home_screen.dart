import 'package:estate_app/real-estate/pages/real_explore.dart';
import 'package:estate_app/real-estate/utils/featured_house_carousel.dart';
import 'package:estate_app/real-estate/utils/real_searchbar.dart';
import 'package:estate_app/real-estate/utils/real_userprofile_row.dart';
import 'package:estate_app/real-estate/utils/recommendation.dart';
import 'package:flutter/material.dart';

class RealHomeScreen extends StatelessWidget {
  const RealHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RealUserprofileRow(),

                    const SizedBox(height: 16),

                    const RealSearchbar(),

                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Featured",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RealExplore(),
                              ),
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
                    const FeaturedHouseCarousel(),

                    const SizedBox(height: 20),

                    Recommendation(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
