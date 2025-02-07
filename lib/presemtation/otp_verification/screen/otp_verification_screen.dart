import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:product_listing_app/presemtation/base/base_screen.dart';
import 'package:product_listing_app/presemtation/home/viemodel/home_view_model.dart';
import 'package:product_listing_app/presemtation/login/view_model/login_view_model.dart';
import 'package:product_listing_app/presemtation/otp_verification/screen/enter_name_screen.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/text_styles.dart';
import '../../../widgets/common_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpVerificationScreen({super.key,required this.phoneNumber});

  @override
  OtpVerificationScreenState createState() => OtpVerificationScreenState();
}

class OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late LoginViewModel loginViewModel;
  late HomeViewModel homeViewModel;

  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  Timer? _timer;
  int _secondsRemaining = 0; // Countdown seconds
  bool _isResendDisabled = false; // Controls whether Re-send is clickable

  @override
  void initState() {
    super.initState();
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    getBanners();
  }
  Future<void> getBanners() async {
    final homeViewModel =
    Provider.of<HomeViewModel>(context, listen: false);
    await homeViewModel.getBanners();
  }
  @override
  void dispose() {
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _timer?.cancel(); // Cancel timer to avoid memory leaks
    super.dispose();
  }

  // Function to start the countdown timer
  void _startResendTimer() {
    setState(() {
      _secondsRemaining = 120; // Reset to 120 seconds
      _isResendDisabled = true; // Disable re-send button
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isResendDisabled = false; // Enable re-send button
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(60),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                child: Image.asset(
                  "assets/images/back_button.png",
                  width: width * 0.2,
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "OTP VERIFICATION",
                style: AppTextStyles.textStyle_700_18.copyWith(
                  color: AppTheme.colors.blackColor,
                ),
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    color: AppTheme.colors.loremIpsumColor,
                  ),
                  children: [
                    const TextSpan(text: "Enter the OTP sent to "),
                    TextSpan(
                      text: "-+91-${widget.phoneNumber}",
                      style: AppTextStyles.textStyle_500_12.copyWith(
                        color: AppTheme.colors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    color: AppTheme.colors.loremIpsumColor,
                  ),
                  children: [
                    const TextSpan(text: "OTP is  "),
                    TextSpan(
                      text: loginViewModel.loginResponse?.otp ?? "",
                      style: AppTextStyles.textStyle_700_14.copyWith(
                        color: AppTheme.colors.themeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(70),
            // OTP input fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildOtpTextField(_otpController1, _focusNode1, _focusNode2,null),
                  Gap(20),
                  _buildOtpTextField(_otpController2, _focusNode2, _focusNode3,_focusNode1),
                  Gap(20),
                  _buildOtpTextField(_otpController3, _focusNode3, _focusNode4,_focusNode2),
                  Gap(20),
                  _buildOtpTextField(_otpController4, _focusNode4, null,_focusNode3),
                ],
              ),
            ),
            Gap(50),

            if (_isResendDisabled) // Show only when the timer is running
              Center(
                child: Text(
                  "00:${_secondsRemaining.toString().padLeft(3, '0')} sec", // Format as 00:120 sec
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    color: AppTheme.colors.blackColor,
                  ),
                ),
              ),

            Gap(20),
            // Re-send GestureDetector
            GestureDetector(
              onTap: _isResendDisabled
                  ? null
                  : () {
                loginViewModel.enterPhoneNumber(widget.phoneNumber);
                _startResendTimer(); // Start countdown timer
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.textStyle_400_14.copyWith(
                          color: AppTheme.colors.loremIpsumColor,
                        ),
                        children: [
                          const TextSpan(text: "Don’t receive code? "),
                          TextSpan(
                            text: " Re-send",
                            style: AppTextStyles.textStyle_500_14.copyWith(
                              color: _isResendDisabled
                                  ? AppTheme.colors.loremIpsumColor
                                  : AppTheme.colors.resendColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: CommonSubmitButton(
                onPressed: () async {
                  String otp = _otpController1.text + _otpController2.text + _otpController3.text + _otpController4.text;
                  if (loginViewModel.loginResponse?.otp == otp) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const BaseScreen(selectedIndex: 'home'),
                        transitionDuration: const Duration(seconds: 0),
                      ),
                    );
                  } else {
                    showSnackBar(context, "OTP does not match",isError: true);
                  }
                },
                isLoading: false,
                buttonText: "Submit",
                isArrow: false,
                style: AppTextStyles.textStyle_600_14.copyWith(color: Colors.white),
                trialIcon: '',
                isBorderContainer: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper method to create OTP text field with common styling
  Widget _buildOtpTextField(
      TextEditingController controller, FocusNode focusNode, FocusNode? nextFocusNode, FocusNode? previousFocusNode) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.colors.backgroundColor, // Set the background color
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 5, // Blur effect for the shadow
            offset: Offset(0, 2), // Position of the shadow
          ),
        ],
      ),
      width: 60,
      child: RawKeyboardListener(
        focusNode: FocusNode(), // To listen for keyboard events
        onKey: (event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty &&
              previousFocusNode != null) {
            FocusScope.of(context).requestFocus(previousFocusNode);
          }
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: AppTextStyles.textStyle_500_14.copyWith(
            color: AppTheme.colors.blackColor,
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none, // Removes the underline
          ),
          onChanged: (value) {
            if (value.isNotEmpty && nextFocusNode != null) {
              // Move to next field if current field is filled
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          onTap: () {
            controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
          },
        ),
      ),
    );
  }

}
