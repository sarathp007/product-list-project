import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:product_listing_app/presemtation/login/view_model/login_view_model.dart';
import 'package:product_listing_app/theme/app_theme.dart';
import 'package:product_listing_app/theme/text_styles.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {

  late LoginViewModel loginViewModel;




  @override
  void initState() {
    super.initState();
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    getProfileInfo();

  }

  Future<void> getProfileInfo() async {
    final loginViewModel =
    Provider.of<LoginViewModel>(context, listen: false);
    await loginViewModel.getProfileInfoApi();
  }

  @override
  void dispose() {
 // Stop the timer in dispose
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "My Profile",
                  style: AppTextStyles.textStyle_500_18.copyWith(
                    color: AppTheme.colors.profileColor,
                  ),
                ),
              ],
            ),
          ),
          Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Name",
                      style: AppTextStyles.textStyle_700_14.copyWith(
                        color: AppTheme.colors.profileNameColor,
                      ),
                    ),
                    Gap(10),
                    Text(
                      loginViewModel.profileInfoResponse?.name ?? "",
                      style: AppTextStyles.textStyle_700_18.copyWith(
                        color: AppTheme.colors.blackColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Phone",
                      style: AppTextStyles.textStyle_700_14.copyWith(
                        color: AppTheme.colors.profileNameColor,
                      ),
                    ),
                    Gap(10),
                    Text(
                      "+91 ${loginViewModel.profileInfoResponse?.phoneNumber ?? ""}",
                      style: AppTextStyles.textStyle_700_18.copyWith(
                        color: AppTheme.colors.blackColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
