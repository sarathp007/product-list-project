import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:product_listing_app/presemtation/base/base_screen.dart';
import 'package:product_listing_app/presemtation/login/view_model/login_view_model.dart';
import 'package:product_listing_app/presemtation/otp_verification/screen/otp_verification_screen.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/text_styles.dart';
import '../../../widgets/common_button.dart';

class EnterNameScreen extends StatefulWidget {
  final String phoneNumber;
  const EnterNameScreen({super.key,    required this.phoneNumber,});

  @override
  EnterNameScreenState createState() => EnterNameScreenState();
}

class EnterNameScreenState extends State<EnterNameScreen> {
  late LoginViewModel loginViewModel;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(60),
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // This will pop the current screen and go back
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
              child: Image.asset(
                "assets/images/back_button.png",
                width: width * 0.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              onChanged: (value){
                loginViewModel.setEnterName(value);
              },
              controller: nameController,
              textAlign: TextAlign.start,
              style: AppTextStyles.textStyle_500_14.copyWith(
                color: AppTheme.colors.blackColor,
              ),
              decoration: InputDecoration(
                hintText: "Enter Full Name",
                hintStyle: AppTextStyles.textStyle_400_14.copyWith(
                  color: AppTheme.colors.loremIpsumColor,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.colors.loremIpsumColor, // Underline color
                    width: 0.1,
                  ),
                ),
              ),
            ),
          ),
          Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: CommonSubmitButton(
              onPressed: () async {
                loginViewModel.loginRegister(widget.phoneNumber);
              //  if(loginViewModel.loginRegisterResponse != null){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                        OtpVerificationScreen(phoneNumber: widget.phoneNumber,),
                      transitionDuration:
                      const Duration(seconds: 0),
                    ),
                  );
               // }else{
                  // Navigator.pushReplacement(
                  //   context,
                  //   PageRouteBuilder(
                  //     pageBuilder: (_, __, ___) =>
                  //     const  BaseScreen(selectedIndex: 'home'),
                  //     transitionDuration:
                  //     const Duration(seconds: 0),
                  //   ),
                  // );
              //  }
                // Handle OTP submission here

                // Proceed to next screen or validation
              },
              isLoading: loginViewModel.isLoginRegisterLoading,
              buttonText: "Submit",
              isArrow: false,
              style: AppTextStyles.textStyle_600_14.copyWith(color: Colors.white),
              trialIcon: '',
              isBorderContainer: false,
            ),
          ),
        ],
      ),
    );
  }

}
