// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';

// /// AuthScreen
// /// -----------
// /// Top: image grid (swap with your real Image.asset grid) + headline +
// /// "Sign Up with Google" button.
// /// Below: two buttons — Sign Up / Login — each opening a bottom sheet
// /// modal with rounded top corners that toggles between sign up and
// /// login forms.
// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

//   static const Color primaryBlue = Color(0xFF2F6BFF);

//   void _openAuthSheet(BuildContext context, {required bool startAsSignUp}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // lets the sheet grow with the keyboard
//       backgroundColor: Colors.transparent,
//       builder: (context) => AuthBottomSheet(startAsSignUp: startAsSignUp),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               const SizedBox(height: 50),

//               // ---- Image (single asset, already a 3x3 grid baked in) ----
//               Container(
//                 decoration: BoxDecoration(),
//                 clipBehavior: Clip.antiAlias,
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       'assets/images/container.png', // <- update to your actual path
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Text(
//                         'WELCOME TO REAL SCOUT',
//                         style: TextStyle(
//                           color: Colors.grey[500],
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 12),

//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   style: const TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     height: 1.3,
//                   ),
//                   children: [
//                     const TextSpan(text: "Let's Get You Closer\nTo "),
//                     TextSpan(
//                       text: 'Your Ideal Home',
//                       style: TextStyle(color: primaryBlue),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Text(
//                 'Login to Real Scout with Google',
//                 style: TextStyle(color: Colors.grey[500], fontSize: 14),
//               ),

//               const SizedBox(height: 20),

//               // ---- Sign Up / Login buttons ----
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 54,
//                       child: ElevatedButton(
//                         onPressed: () =>
//                             _openAuthSheet(context, startAsSignUp: true),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryBlue,
//                           foregroundColor: Colors.white,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: const Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: SizedBox(
//                       height: 54,
//                       child: OutlinedButton(
//                         onPressed: () =>
//                             _openAuthSheet(context, startAsSignUp: false),
//                         style: OutlinedButton.styleFrom(
//                           side: BorderSide(color: primaryBlue, width: 1.5),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: Text(
//                           'Login',
//                           style: TextStyle(
//                             color: primaryBlue,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// The bottom sheet itself — handles its own toggle state between
// /// Sign Up and Login so the parent screen stays simple.
// class AuthBottomSheet extends StatefulWidget {
//   final bool startAsSignUp;

//   const AuthBottomSheet({super.key, required this.startAsSignUp});

//   @override
//   State<AuthBottomSheet> createState() => _AuthBottomSheetState();
// }

// class _AuthBottomSheetState extends State<AuthBottomSheet> {
//   late bool isSignUp;

//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   static const Color primaryBlue = Color(0xFF2F6BFF);

//   @override
//   void initState() {
//     super.initState();
//     isSignUp = widget.startAsSignUp;
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _toggleMode() {
//     setState(() => isSignUp = !isSignUp);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Pushes the sheet up above the keyboard, and lets it size to content.
//     final bottomInset = MediaQuery.of(context).viewInsets.bottom;

//     return AnimatedPadding(
//       duration: const Duration(milliseconds: 150),
//       padding: EdgeInsets.only(bottom: bottomInset),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(28),
//             topRight: Radius.circular(28),
//           ),
//         ),
//         child: SafeArea(
//           top: false,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // drag handle
//                 Center(
//                   child: Container(
//                     width: 42,
//                     height: 4,
//                     margin: const EdgeInsets.only(bottom: 18),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),

//                 Text(
//                   isSignUp ? 'Create an Account' : 'Welcome Back',
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   isSignUp
//                       ? 'Sign up to start your home search'
//                       : 'Login to continue your home search',
//                   style: TextStyle(color: Colors.grey[500], fontSize: 14),
//                 ),

//                 const SizedBox(height: 24),

//                 // ---- Form fields ----
//                 if (isSignUp) ...[
//                   _buildLabel('Name'),
//                   _buildTextField(
//                     controller: _nameController,
//                     hint: 'Enter your full name',
//                     icon: HugeIcons.strokeRoundedUser,
//                   ),
//                   const SizedBox(height: 16),
//                 ],

//                 _buildLabel('Email'),
//                 _buildTextField(
//                   controller: _emailController,
//                   hint: 'Enter your email',
//                   icon: HugeIcons.strokeRoundedMail01,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 16),

//                 _buildLabel('Password'),
//                 _buildTextField(
//                   controller: _passwordController,
//                   hint: 'Enter your password',
//                   icon: HugeIcons.strokeRoundedLockPassword,
//                   obscureText: _obscurePassword,
//                   isPasswordField: true,
//                   onToggleObscure: () =>
//                       setState(() => _obscurePassword = !_obscurePassword),
//                 ),

//                 if (isSignUp) ...[
//                   const SizedBox(height: 16),
//                   _buildLabel('Confirm Password'),
//                   _buildTextField(
//                     controller: _confirmPasswordController,
//                     hint: 'Re-enter your password',
//                     icon: HugeIcons.strokeRoundedLockPassword,
//                     obscureText: _obscureConfirmPassword,
//                     isPasswordField: true,
//                     onToggleObscure: () => setState(
//                       () => _obscureConfirmPassword = !_obscureConfirmPassword,
//                     ),
//                   ),
//                 ],

//                 const SizedBox(height: 26),

//                 // ---- Submit button ----
//                 SizedBox(
//                   height: 54,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Hook up your auth logic here (Convex/Clerk, etc.)
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: primaryBlue,
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: Text(
//                       isSignUp ? 'Sign Up' : 'Login',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 // ---- Toggle link ----
//                 Center(
//                   child: GestureDetector(
//                     onTap: _toggleMode,
//                     child: RichText(
//                       text: TextSpan(
//                         style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                         children: [
//                           TextSpan(
//                             text: isSignUp
//                                 ? 'Already have an account? '
//                                 : "Don't have an account? ",
//                           ),
//                           TextSpan(
//                             text: isSignUp ? 'Login' : 'Sign Up',
//                             style: const TextStyle(
//                               color: primaryBlue,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8, left: 2),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//     required dynamic icon,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//     bool isPasswordField = false,
//     VoidCallback? onToggleObscure,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       style: const TextStyle(fontSize: 15, color: Colors.black),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
//         prefixIcon: Padding(
//           padding: const EdgeInsets.all(14),
//           child: HugeIcon(icon: icon, color: Colors.grey[500]!, size: 20),
//         ),
//         suffixIcon: isPasswordField
//             ? IconButton(
//                 onPressed: onToggleObscure,
//                 icon: HugeIcon(
//                   icon: obscureText
//                       ? HugeIcons.strokeRoundedView
//                       : HugeIcons.strokeRoundedViewOff,
//                   color: Colors.grey[500]!,
//                   size: 20,
//                 ),
//               )
//             : null,
//         filled: true,
//         fillColor: Colors.grey[100],
//         contentPadding: const EdgeInsets.symmetric(vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: primaryBlue, width: 1.5),
//         ),
//       ),
//     );
//   }
// }
