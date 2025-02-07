import 'package:flutter/material.dart';
import 'package:product_listing_app/theme/app_theme.dart';
import 'package:product_listing_app/theme/text_styles.dart';

class CustomPhoneInput extends StatelessWidget {
  final TextEditingController phoneController;

  const CustomPhoneInput({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end, // Aligns both elements at the bottom
          children: [
            // +91 Prefix with aligned underline
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Baseline(
                  baseline: 20, // Adjust to match text input baseline
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    "+91",
                    style: AppTextStyles.textStyle_400_16.copyWith(
                      color: AppTheme.colors.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12), // Space between text and underline
                Container(
                  height: 1, // Thickness of underline
                  width: double.infinity, // Full width of input
                  color: AppTheme.colors.loremIpsumColor,
                ),
              ],
            ),
            const SizedBox(width: 10), // Space between +91 and input field

            // Phone number input with aligned underline
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: AppTextStyles.textStyle_400_16.copyWith(
                      color: AppTheme.colors.blackColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter Phone",
                      hintStyle: AppTextStyles.textStyle_400_16.copyWith(
                        color: AppTheme.colors.placeholderColor,
                      ),
                      border: InputBorder.none, // No border, only underline
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      } else if (value.length < 10) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 1, // Thickness of underline
                    width: double.infinity, // Full width of input
                    color: AppTheme.colors.loremIpsumColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
