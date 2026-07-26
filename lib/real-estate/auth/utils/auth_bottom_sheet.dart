import 'package:estate_app/real-estate/utils/real_navbar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'auth_text_field.dart';
import 'auth_toggle_link.dart';

/// The bottom sheet itself — handles its own toggle state between
/// Sign Up and Login, and navigates to RealNavbar() on submit.
class AuthBottomSheet extends StatefulWidget {
  final bool startAsSignUp;
  final Color primaryColor;

  const AuthBottomSheet({
    super.key,
    required this.startAsSignUp,
    required this.primaryColor,
  });

  @override
  State<AuthBottomSheet> createState() => _AuthBottomSheetState();
}

class _AuthBottomSheetState extends State<AuthBottomSheet> {
  late bool isSignUp;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    isSignUp = widget.startAsSignUp;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() => isSignUp = !isSignUp);
  }

  void _handleSubmit() {
    // Hook up your real Convex/Clerk auth call here.
    // On success, take the user to RealNavbar().
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const RealNavbar()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Text(
                  isSignUp ? 'Create an Account' : 'Welcome Back',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isSignUp
                      ? 'Sign up to start your home search'
                      : 'Login to continue your home search',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),

                const SizedBox(height: 24),

                if (isSignUp) ...[
                  AuthTextField(
                    label: 'Name',
                    controller: _nameController,
                    hint: 'Enter your full name',
                    icon: HugeIcons.strokeRoundedUser,
                    focusColor: widget.primaryColor,
                  ),
                  const SizedBox(height: 16),
                ],

                AuthTextField(
                  label: 'Email',
                  controller: _emailController,
                  hint: 'Enter your email',
                  icon: HugeIcons.strokeRoundedMail01,
                  keyboardType: TextInputType.emailAddress,
                  focusColor: widget.primaryColor,
                ),
                const SizedBox(height: 16),

                AuthTextField(
                  label: 'Password',
                  controller: _passwordController,
                  hint: 'Enter your password',
                  icon: HugeIcons.strokeRoundedLockPassword,
                  obscureText: _obscurePassword,
                  isPasswordField: true,
                  focusColor: widget.primaryColor,
                  onToggleObscure: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),

                if (isSignUp) ...[
                  const SizedBox(height: 16),
                  AuthTextField(
                    label: 'Confirm Password',
                    controller: _confirmPasswordController,
                    hint: 'Re-enter your password',
                    icon: HugeIcons.strokeRoundedLockPassword,
                    obscureText: _obscureConfirmPassword,
                    isPasswordField: true,
                    focusColor: widget.primaryColor,
                    onToggleObscure: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                  ),
                ],

                const SizedBox(height: 26),

                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      isSignUp ? 'Sign Up' : 'Login',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                AuthToggleLink(
                  isSignUp: isSignUp,
                  highlightColor: widget.primaryColor,
                  onTap: _toggleMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
