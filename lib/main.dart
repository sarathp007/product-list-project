
import 'package:flutter/material.dart';
import 'package:product_listing_app/data/cache/Cache_manager.dart';
import 'package:product_listing_app/presemtation/splash/splash_screen.dart';

import 'config/app_providers.dart';






Future<void> main() async {
  runApp(appProviders());
  await CacheManager.init();


}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'product-listing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}
