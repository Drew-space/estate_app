import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Map<String, dynamic> house;

  const PropertyDetailScreen({super.key, required this.house});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final PageController _pageController = PageController();
  int _currentImage = 0;

  static const double _imageHeight = 530;
  static const double _cardOverlap = 28;

  final Map<String, dynamic> _facilityIcons = {
    "Car Parking": HugeIcons.strokeRoundedCar01,
    "Swimming Pool": HugeIcons.strokeRoundedSwimming,
    "Gym & Fitness": HugeIcons.strokeRoundedDumbbell01,
    "Restaurant": HugeIcons.strokeRoundedRestaurant01,
    "Wi-fi & Network": HugeIcons.strokeRoundedWifi01,
    "Pet Center": HugeIcons.strokeRoundedFavourite,
    "Sport Center": HugeIcons.strokeRoundedFootball,
    "Laundry": HugeIcons.strokeRoundedClapping02,
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final house = widget.house;
    final List<String> images = List<String>.from(house["images"] ?? []);
    final List<String> facilities = List<String>.from(
      house["facilities"] ?? [],
    );

    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE CAROUSEL
                Stack(
                  children: [
                    SizedBox(
                      height: _imageHeight,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _currentImage = index);
                        },
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          // return Image.network(
                          //   images[index],
                          //   fit: BoxFit.cover,
                          //   width: double.infinity,
                          // );
                          return CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
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
                          );
                        },
                      ),
                    ),

                    // (back, share, favorite)
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CircleIconButton(
                              icon: HugeIcons.strokeRoundedArrowLeft01,
                              onTap: () => Navigator.pop(context),
                            ),
                            Row(
                              children: [
                                _CircleIconButton(
                                  icon: HugeIcons.strokeRoundedFavourite,
                                  onTap: () {},
                                ),
                                const SizedBox(width: 10),
                                _CircleIconButton(
                                  icon: HugeIcons.strokeRoundedShare08,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (images.length > 1)
                      Positioned(
                        bottom: _cardOverlap + 14,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: images.length,
                            effect: const WormEffect(
                              dotHeight: 7,
                              dotWidth: 7,
                              spacing: 6,
                              activeDotColor: Color(0xff246BFD),
                              dotColor: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                Transform.translate(
                  offset: Offset(0, -_cardOverlap),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// category badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffEEF2F6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            (house["category"] ?? "").toString().toUpperCase(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff246BFD),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// TITLE + RATING
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                house["title"] ?? "",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${house["rating"] ?? 4.8}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              house["location"] ?? "",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${house["reviews"] ?? 0} Reviews",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        ///  (beds / baths / sqft)
                        Row(
                          children: [
                            _InfoPill(
                              icon: HugeIcons.strokeRoundedBed,
                              label: house["beds"] ?? "—",
                            ),
                            const SizedBox(width: 10),
                            _InfoPill(
                              icon: HugeIcons.strokeRoundedBathtub01,
                              label: house["baths"] ?? "—",
                            ),
                            const SizedBox(width: 10),
                            _InfoPill(
                              icon: HugeIcons.strokeRoundedRuler,
                              label: house["sqft"] ?? "—",
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 20),

                        ///  agent
                        const Text(
                          "Agent",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                house["agentImage"] ?? "",
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    house["agentName"] ?? "Agent",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    house["agentRole"] ?? "",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _CircleIconButton(
                              icon: HugeIcons.strokeRoundedMessage01,
                              onTap: () {},
                              background: const Color(0xffEEF2F6),
                              iconColor: const Color(0xff246BFD),
                            ),
                            const SizedBox(width: 10),
                            _CircleIconButton(
                              icon: HugeIcons.strokeRoundedCall02,
                              onTap: () {},
                              background: const Color(0xffEEF2F6),
                              iconColor: const Color(0xff246BFD),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          "Overview",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          house["description"] ?? "",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 24),

                        if (facilities.isNotEmpty) ...[
                          const Text(
                            "Facilities",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: facilities.map((facility) {
                              return _FacilityItem(
                                icon:
                                    _facilityIcons[facility] ??
                                    HugeIcons.strokeRoundedCheckmarkCircle01,
                                label: facility,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],

                        /// GALLERY — only if more than 1 image
                        if (images.length > 1) ...[
                          const Text(
                            "Gallery",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  // child: Image.network(
                                  //   images[index],
                                  //   width: 80,
                                  //   height: 80,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  child: CachedNetworkImage(
                                    imageUrl: images[index],
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey.shade200,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          color: Colors.grey.shade200,
                                          child: const Icon(Icons.broken_image),
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        /// LOCATION
                        const Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Color(0xff246BFD),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                house["address"] ?? house["location"] ?? "",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// space for the sticky bottom bar so content
                        /// doesn't get hidden behind it
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// FLOATING PRICE / BOOKING BAR
          Positioned(
            left: 20,
            right: 20,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PRICE",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            house["price"] ?? "",
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff246BFD),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff246BFD),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Booking Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small reusable circular icon button used in the top bar + agent row
class _CircleIconButton extends StatelessWidget {
  final dynamic icon;
  final VoidCallback onTap;
  final Color background;
  final Color iconColor;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.background = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: HugeIcon(icon: icon, color: iconColor, size: 18),
      ),
    );
  }
}

/// Beds / Baths / Sqft pill
class _InfoPill extends StatelessWidget {
  final dynamic icon;
  final String label;

  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffEEF2F6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(icon: icon, size: 16, color: const Color(0xff246BFD)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

/// Facility icon + label, used in the Wrap grid
class _FacilityItem extends StatelessWidget {
  final dynamic icon;
  final String label;

  const _FacilityItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xffEEF2F6),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: HugeIcon(icon: icon, color: const Color(0xff246BFD)),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
