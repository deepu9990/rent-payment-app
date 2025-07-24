import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 140, // Increased height to prevent overflow
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showBackButton) ...[
                GestureDetector(
                  onTap:
                      onBackPressed ??
                      () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ] else
                const SizedBox(height: 16),

              Flexible(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Parabolica',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                      height: 1.2, // Adjusted line height
                      color: Color(0xFF202020),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              if (actions != null) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ],
            ],
          ),
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, color: AppColors.borderColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140 + 1); // Updated for new height
}
