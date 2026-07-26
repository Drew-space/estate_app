import 'package:estate_app/real-estate/auth/utils/auth_action_buttons.dart';
import 'package:estate_app/real-estate/auth/utils/auth_bottom_sheet.dart';
import 'package:estate_app/real-estate/auth/utils/auth_headline.dart';
import 'package:estate_app/real-estate/auth/utils/auth_image_header.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

/// AuthScreen
/// -----------
/// Composes the extracted components from utils/:
/// - AuthImageHeader  -> image + "WELCOME TO REAL SCOUT" caption
/// - AuthHeadline     -> "Let's Get You Closer..." + Google subtext
/// - AuthActionButtons -> Sign Up / Login button row
/// - AuthBottomSheet  -> the modal with the form + toggle (own file)
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const Color primaryBlue = Color(0xFF2F6BFF);

  void _openAuthSheet(BuildContext context, {required bool startAsSignUp}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AuthBottomSheet(
        startAsSignUp: startAsSignUp,
        primaryColor: primaryBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),

                const AuthImageHeader(),

                const SizedBox(height: 12),

                const AuthHeadline(highlightColor: primaryBlue),

                const SizedBox(height: 20),

                AuthActionButtons(
                  primaryColor: primaryBlue,
                  onSignUpTap: () =>
                      _openAuthSheet(context, startAsSignUp: true),
                  onLoginTap: () =>
                      _openAuthSheet(context, startAsSignUp: false),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
