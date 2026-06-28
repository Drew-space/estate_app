import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class RealExploreSearchBar extends StatelessWidget {
  const RealExploreSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        prefixIcon: SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: Colors.grey.shade600,
              size: 20,
            ),
          ),
        ),
        suffixIcon: SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedFilterHorizontal,
              color: Colors.grey.shade600,
              size: 20,
            ),
          ),
        ),
        hintText: "Search...",
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade600,
        ),
        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
