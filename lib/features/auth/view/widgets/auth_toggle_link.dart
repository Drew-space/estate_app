import 'package:flutter/material.dart';

/// "Already have an account? Login" / "Don't have an account? Sign Up"
/// tappable text that flips the bottom sheet between modes.
class AuthToggleLink extends StatelessWidget {
  final bool isSignUp;
  final Color highlightColor;
  final VoidCallback onTap;

  const AuthToggleLink({
    super.key,
    required this.isSignUp,
    required this.highlightColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            children: [
              TextSpan(
                text: isSignUp
                    ? 'Already have an account? '
                    : "Don't have an account? ",
              ),
              TextSpan(
                text: isSignUp ? 'Login' : 'Sign Up',
                style: TextStyle(
                  color: highlightColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
