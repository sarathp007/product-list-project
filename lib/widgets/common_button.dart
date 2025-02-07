
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../theme/app_theme.dart';



class CommonSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String buttonText;
  final ValueNotifier<bool>? isEnabled; // Use ValueNotifier
  final bool? isArrow;
  final TextStyle style;
  final String? trialIcon;
  final bool? isBorderContainer;
  final double? width;

  const CommonSubmitButton({
    Key? key,
    required this.onPressed,
    required this.isLoading,
    required this.buttonText,
    this.isEnabled,
    required this.isArrow,
    required this.style,
    required this.trialIcon,
    required this.isBorderContainer,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isEnabled ?? ValueNotifier(true), // Provide a
      builder: (context, enabled, child) {
        return GestureDetector(
          onTap: enabled ? onPressed : null,
          child: Container(
            width: width ?? double.infinity,
            height: 50,
            decoration: isBorderContainer == true
                ? ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: enabled ? AppTheme.colors.textColor : Colors.grey,
                ),
              ),
            )
                : BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: enabled
                    ? AppTheme.colors.themeColor // Use themeColor if enabled
                    : Colors.grey // Use disabledButtonColor if disabled
            ),
            child: Center(
              child: isLoading
                  ? const CupertinoActivityIndicator(
                color: Colors.white,
                animating: true,
              )
                  : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: isArrow == true
                      ? MainAxisAlignment.spaceBetween
                      : trialIcon != null && trialIcon!.isNotEmpty
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    if (trialIcon != null && trialIcon!.isNotEmpty)
                      Row(
                        children: [
                          SvgPicture.asset(trialIcon!),
                          const Gap(10),
                        ],
                      ),
                    DefaultTextStyle(
                      style: style.copyWith(
                        color: Colors.white, // Text color is always white now
                      ),
                      child: Text(buttonText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


void showSnackBar(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.red :AppTheme.colors.themeColor, // Red for errors, Blue for success/info
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

