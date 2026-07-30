import 'package:estate_app/features/home/viewmodel/house_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class RealExploreSearchBar extends ConsumerWidget {
  const RealExploreSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (value) {
        ref.read(exploreSearchQueryProvider.notifier).state = value;
      },

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),

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
        fillColor: Colors.grey.shade100,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
