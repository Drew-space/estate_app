import 'dart:async';
import 'package:estate_app/features/home/viewmodel/house_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class RealSearchbar extends ConsumerStatefulWidget {
  const RealSearchbar({super.key});

  @override
  ConsumerState<RealSearchbar> createState() => _RealSearchbarState();
}

class _RealSearchbarState extends ConsumerState<RealSearchbar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(homeSearchQueryProvider.notifier).state = value;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
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
