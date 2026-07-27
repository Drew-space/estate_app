import 'package:estate_app/core/widgets/real_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final _usernameController = TextEditingController();
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
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _createUser() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter a username.',
        gravity: ToastGravity.TOP,
      );
      return;
    }

    if (password != confirmPassword) {
      Fluttertoast.showToast(
        msg: 'Passwords do not match.',
        gravity: ToastGravity.TOP,
      );
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user == null) return;

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'username': username,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      Fluttertoast.showToast(
        msg: 'Account created successfully!',
        gravity: ToastGravity.TOP,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RealNavbar()),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = 'Something went wrong. Please try again.';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        print('Firebase error: ${e.code}');
        print('Message: $message');
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
        print('Firebase error: ${e.code}');
        print('Message: $message');
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
        print('Firebase error: ${e.code}');
        print('Message: $message');
      }

      Fluttertoast.showToast(msg: message, gravity: ToastGravity.TOP);
    } catch (e) {
      if (!mounted) return;

      Fluttertoast.showToast(
        msg: 'Something went wrong. Please try again.',
        gravity: ToastGravity.TOP,
      );
    }
  }

  void _toggleMode() {
    setState(() => isSignUp = !isSignUp);
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your email and password.',
        gravity: ToastGravity.TOP,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Fluttertoast.showToast(msg: 'Welcome back!', gravity: ToastGravity.TOP);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const RealNavbar()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = 'Something went wrong. Please try again.';

      if (e.code == 'user-not-found') {
        message = 'No account found for that email.';
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'Incorrect email or password.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      }

      Fluttertoast.showToast(msg: message, gravity: ToastGravity.TOP);
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: 'Something went wrong. Please try again.',
        gravity: ToastGravity.TOP,
      );
    }
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
                    label: 'Username',
                    controller: _usernameController,
                    hint: 'Enter your username',
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
                    onPressed: isSignUp ? _createUser : _signIn,
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
