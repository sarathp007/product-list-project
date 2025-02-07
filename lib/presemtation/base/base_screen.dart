import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:product_listing_app/presemtation/home/screen/home_screen.dart';
import 'package:product_listing_app/presemtation/login/screen/login_screen.dart';
import 'package:product_listing_app/presemtation/profile/screen/profile_screen.dart';
import 'package:product_listing_app/presemtation/wishlist/wishlist_screen.dart';

import '../../theme/app_theme.dart';

class BaseScreen extends StatefulWidget {
  final String selectedIndex;

  const BaseScreen({super.key, required this.selectedIndex});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  var logger = Logger();
  var connectivityResult;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeSelectedIndex();
    Connectivity().onConnectivityChanged.listen((newResult) {
      setState(() {
        connectivityResult = newResult;
      });
      logger.e("Network status changed: $connectivityResult");
    });
  }

  void _initializeSelectedIndex() {
    switch (widget.selectedIndex) {
      case "home":
        _selectedIndex = 0;
        break;
      case "wishlist":
        _selectedIndex = 1;
        break;
      case "profile":
        _selectedIndex = 2;
        break;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: (connectivityResult == ConnectivityResult.none)
          ? Container(
        height: height * 0.2, // Reduce the height, e.g., to 20% of the screen
        color: AppTheme.colors.themeColor,
        child: const Center(child: Text("No Internet")),
      )
          : _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/home_in_active_icon.svg'),
                    activeIcon: SvgPicture.asset('assets/images/home_active_icon.svg'),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/wishlist_in_active_icon.svg'),
                    activeIcon: SvgPicture.asset('assets/images/wishlist_active_icon.svg'),
                    label: 'Wishlist',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/profile_in_active_icon.svg'),
                    activeIcon: SvgPicture.asset('assets/images/profile_active_icon.svg'),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
