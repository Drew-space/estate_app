import 'package:flutter/material.dart';

/// The two side-by-side buttons — Sign Up (filled) and Login (outlined) —
/// each opening the auth bottom sheet in its respective mode.
class AuthActionButtons extends StatelessWidget {
  final Color primaryColor;
  final VoidCallback onSignUpTap;
  final VoidCallback onLoginTap;

  const AuthActionButtons({
    super.key,
    required this.primaryColor,
    required this.onSignUpTap,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: onSignUpTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 54,
            child: OutlinedButton(
              onPressed: onLoginTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
