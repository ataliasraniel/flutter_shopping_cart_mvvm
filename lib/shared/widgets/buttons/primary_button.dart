import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_colors.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_spacing.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;
  final IconData? icon;
  final bool? onPrimary;
  final bool? isFullWidth;
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.icon,
    this.onPrimary,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = onPrimary == false ? AppColors.surface : AppColors.primary;
    final Color textColor = onPrimary == true ? AppColors.textPrimary : AppColors.background;
    if (icon != null) {
      return SizedBox(
        width: isFullWidth == true ? double.infinity : null,
        child: ElevatedButton.icon(
          onPressed: isEnabled && !isLoading ? onPressed : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: kMediumSize, horizontal: 32.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            backgroundColor: buttonColor,
          ),
          icon: isLoading
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0))
              : Icon(icon, color: textColor),
          label: Text(
            label,
            textAlign: .center,

            style: TextStyle(fontSize: 16.0, color: textColor),
          ),
        ),
      );
    }
    return SizedBox(
      width: isFullWidth == true ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: kMediumSize, horizontal: 32.0),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0))
            : Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: textColor),
              ),
      ),
    );
  }
}
