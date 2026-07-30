import 'package:flutter/material.dart';

class AuthHeadline extends StatelessWidget {
  final Color highlightColor;

  const AuthHeadline({super.key, required this.highlightColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.3,
            ),
            children: [
              const TextSpan(text: "Let's Get You Closer\nTo "),
              TextSpan(
                text: 'Your Ideal Home',
                style: TextStyle(color: highlightColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Login to Real Scout ',
          style: TextStyle(color: Colors.grey[500], fontSize: 14),
        ),
      ],
    );
  }
}
