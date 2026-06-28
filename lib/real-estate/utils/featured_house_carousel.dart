import 'package:flutter/material.dart';
import 'real_house.dart';
import 'real_house_card.dart';

class FeaturedHouseCarousel extends StatefulWidget {
  const FeaturedHouseCarousel({super.key});

  @override
  State<FeaturedHouseCarousel> createState() => _FeaturedHouseCarouselState();
}

class _FeaturedHouseCarouselState extends State<FeaturedHouseCarousel> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: CarouselView.weighted(
        controller: controller,
        itemSnapping: true,
        flexWeights: const [1, 7, 1],
        children: houses.map((house) => HouseCard(house: house)).toList(),
      ),
    );
  }
}
