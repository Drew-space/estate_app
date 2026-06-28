import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class RealExploreSearchBar extends StatelessWidget {
  const RealExploreSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          HugeIcon(icon: HugeIcons.strokeRoundedSearch01),
          SizedBox(width: 10),

          Expanded(
            child: Text(
              "Search houses, villas...",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          HugeIcon(icon: HugeIcons.strokeRoundedFilterHorizontal),
        ],
      ),
    );
  }
}
