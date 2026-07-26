import 'package:flutter/material.dart';

/// Single image asset (already a 3x3 grid baked in) with a
/// rounded blue border and a caption underneath.
class AuthImageHeader extends StatelessWidget {
  final String imagePath;

  final String caption;

  const AuthImageHeader({
    super.key,
    this.imagePath = 'assets/images/container.png',

    this.caption = 'WELCOME TO REAL SCOUT',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: double.infinity, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            caption,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
