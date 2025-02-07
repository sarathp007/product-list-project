import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:product_listing_app/presemtation/login/view_model/login_view_model.dart';
import 'package:product_listing_app/presemtation/otp_verification/screen/enter_name_screen.dart';
import 'package:product_listing_app/presemtation/otp_verification/screen/otp_verification_screen.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/text_styles.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/custome_text_fied.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);  //
  late LoginViewModel loginViewModel;
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    phoneController.addListener(_updateButtonState); // Add listener
    super.initState();
  }

  @override
  void dispose() {
    phoneController.removeListener(_updateButtonState); // Remove listener
    phoneController.dispose();
    isButtonEnabled.dispose(); // Dispose ValueNotifier
    super.dispose();
  }

  void _updateButtonState() {
    isButtonEnabled.value = phoneController.text.isNotEmpty; // Update the value
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 170),
            Text(
              "Login",
              style: AppTextStyles.textStyle_700_30.copyWith(
                color: AppTheme.colors.blackColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Let’s Connect with Lorem Ipsum..!",
              style: AppTextStyles.textStyle_400_16.copyWith(
                color: AppTheme.colors.loremIpsumColor,
              ),
            ),
            const SizedBox(height: 40), // Space before phone number field
// Phone number text field
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "+91",
                      style: AppTextStyles.textStyle_400_16.copyWith(
                        color: AppTheme.colors.loremIpsumColor,
                      ),
                    ),

                  ],
                ),
                const SizedBox(width: 8), // Add some space between the +91 and the text field
                Expanded(
                  child: TextField(
                    onChanged: (value){
                      loginViewModel.setEnterPhoneNumber(value);
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Only allow digits
                      LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter Phone',
                      hintStyle: AppTextStyles.textStyle_400_16.copyWith(
                        color: AppTheme.colors.loremIpsumColor,
                      ),
                      border:  UnderlineInputBorder( // Add const here
                        borderSide: BorderSide(
                          color: AppTheme.colors.loremIpsumColor, // Underline color
                          width: 0.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30), // Space before phone number field
            CommonSubmitButton(
                isEnabled: isButtonEnabled, // Pass the ValueNotifier
                onPressed: () async {
                  await loginViewModel.enterPhoneNumber(phoneController.text);
                  if(phoneController.text.length == 10){
                    if(loginViewModel.loginResponse?.user != false){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => OtpVerificationScreen(phoneNumber: phoneController.text,),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      );
                    }else{
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>  EnterNameScreen(phoneNumber: phoneController.text,),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      );
                    }
                  }else{
                    showSnackBar(context, "Invalid Phone Number",isError: true);
                  }


                },
                isLoading: loginViewModel.isLoading,
                buttonText: "Continue",
                isArrow: false,
                style: AppTextStyles.textStyle_600_14
                    .copyWith(color: Colors.white),
                trialIcon: '',
                isBorderContainer: false),
            const SizedBox(height: 30), // Space before phone number field
            Center(
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.textStyle_300_11.copyWith(
                    color: AppTheme.colors.loremIpsumColor,
                  ),
                  children: [
                    TextSpan(
                      text: "By Continuing you accepting the ",
                    ),
                    TextSpan(
                      text: "Terms of Use &",
                      style: AppTextStyles.textStyle_400_11.copyWith(
                        color: AppTheme.colors.loremIpsumColor,
                        decoration: TextDecoration.underline, // Underline the text
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2), // Space before phone number field
            Center(
              child: Text(
                "Privacy Policy",
                style: AppTextStyles.textStyle_400_11.copyWith(
                  color: AppTheme.colors.loremIpsumColor,
                  decoration: TextDecoration.underline, // Adds underline
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
