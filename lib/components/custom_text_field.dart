import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final bool isRequired;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hint,
    this.isRequired = false,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              validator: validator,
              onTap: onTap,
              readOnly: readOnly,
              onChanged: onChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
                letterSpacing: 0.02,
              ),
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                labelStyle: const TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFAAAAAA),
                  letterSpacing: 0.02,
                ),
                floatingLabelStyle: const TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryBlue,
                ),
                hintStyle: const TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFAAAAAA),
                  letterSpacing: 0.02,
                ),
                suffixIcon: suffixIcon,
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                errorStyle: const TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 12,
                  color: AppColors.errorColor,
                ),
              ),
            ),
            if (isRequired)
              Positioned(
                right: 32,
                top: 18,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: const Text(
                    '(Required)',
                    style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFAAAAAA),
                    ),
                  ),
                ),
              ),
              
          ],
        ),
      ],
    );
  }
}
