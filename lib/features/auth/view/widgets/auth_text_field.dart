import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

/// A label + input field combo used for Name, Email, Password, etc.
/// Pass [isPasswordField] to get a show/hide eye toggle.
class AuthTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final dynamic icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isPasswordField;
  final Color focusColor;
  final VoidCallback? onToggleObscure;

  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.focusColor,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPasswordField = false,
    this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 2),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 15, color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: HugeIcon(icon: icon, color: Colors.grey[500]!, size: 20),
            ),
            suffixIcon: isPasswordField
                ? IconButton(
                    onPressed: onToggleObscure,
                    icon: HugeIcon(
                      icon: obscureText
                          ? HugeIcons.strokeRoundedView
                          : HugeIcons.strokeRoundedViewOff,
                      color: Colors.grey[500]!,
                      size: 20,
                    ),
                  )
                : null,
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: focusColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
