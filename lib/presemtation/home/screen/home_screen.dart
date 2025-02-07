import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:product_listing_app/models/response/getProductListResponse.dart';
import 'package:product_listing_app/models/response/get_banner_response.dart';
import 'package:product_listing_app/presemtation/home/viemodel/home_view_model.dart';
import 'package:product_listing_app/theme/app_theme.dart';
import 'package:product_listing_app/theme/text_styles.dart';
import 'package:product_listing_app/widgets/common_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async'; // Import dart:async for Timer

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<GetProductListResponse> allProducts = []; // Store all products
  List<GetProductListResponse> filteredProducts = []; // Store filtered products
  late HomeViewModel homeViewModel;
  final TextEditingController nameController = TextEditingController();
  final List<String> bannerImages = [
    'assets/images/banner.png',
    'assets/images/banner.png',
    'assets/images/banner.png',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0; // Keep track of the current page

  Timer? _timer; // Declare a Timer variable

  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    getProducts();
    _startAutoScroll(); // Start the auto-scrolling timer
    nameController.addListener(_searchProducts);
  }

  Future<void> getProducts() async {
    await homeViewModel.getProducts();
    setState(() {
      allProducts = homeViewModel.products ?? [];
      filteredProducts = allProducts; // Initially, show all products
    });
  }

  void _searchProducts() {
    String query = nameController.text.toLowerCase();
    setState(() {
      filteredProducts = allProducts.where((product) {
        return product.name!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    _pageController.dispose();
    _stopAutoScroll(); // Stop the timer in dispose
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      // Change to 3 seconds
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back to the first page
      }

      if (_pageController.hasClients) {
        // Check if the PageController is attached
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          // Adjust animation duration
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel(); // Cancel the timer if it's running
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final List<String> bannerImages =
        homeViewModel.banners?.map((banner) => banner.image ?? '').toList() ??
            [];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        filled: false,
                      ),
                    ),
                  ),
                  const Gap(8),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      print('Search: ${nameController.text}');
                    },
                  ),
                ],
              ),
            ),
          ),
          Gap(15),
          if (bannerImages.isNotEmpty) ...[
            SizedBox(
              height: 140,
              child: PageView.builder(
                controller: _pageController,
                itemCount: bannerImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        bannerImages[index],
                        width: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Icon(Icons.image_not_supported, size: 50));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(10),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: bannerImages.length,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 2.0,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.black,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ] else ...[
            const Center(child: CircularProgressIndicator()),
            // Show loading while fetching banners
          ],
          Gap(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Popular Product",
              style: AppTextStyles.textStyle_500_18.copyWith(
                color: AppTheme.colors.blackColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: homeViewModel.isProductLoading
                  ? Center(
                      child:  CupertinoActivityIndicator(
                        color: AppTheme.colors.themeColor,
                        animating: true,
                      ),
                    )
                  : filteredProducts.isEmpty
                      ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/no_wish_list.png",width: width * 0.4,),
                    Gap(10),
                    Text("No Product found",style: AppTextStyles.textStyle_700_12
                        .copyWith(color: AppTheme.colors.blackColor),)
                  ],
                ),
              )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 2,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            final num mrp =
                                product.mrp is num ? product.mrp as num : 0;
                            final num discount = product.discount is num
                                ? product.discount as num
                                : num.tryParse(
                                        product.discount.toString() ?? '0') ??
                                    0;
                            final num discountedPrice = mrp - discount;
                            final double rating = 4.5;

                            //  Add a local state variable to track wishlist status for this card
                            return _WishlistCard(
                                product: product,
                                discountedPrice: discountedPrice,
                                mrp: mrp,
                                rating: rating);
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WishlistCard extends StatefulWidget {
  final dynamic product;
  final num discountedPrice;
  final num mrp;
  final double rating;

  const _WishlistCard({
    Key? key,
    required this.product,
    required this.discountedPrice,
    required this.mrp,
    required this.rating,
  }) : super(key: key);

  @override
  State<_WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<_WishlistCard> {
  late HomeViewModel homeViewModel;
  bool _isWishlisted = false; //  Initial state: not wishlisted

  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    widget.product?.featuredImage ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "₹${widget.product?.mrp}",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "₹${widget.discountedPrice}",
                              style: AppTextStyles.textStyle_700_16
                                  .copyWith(color: AppTheme.colors.themeColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            Text(
                              widget.rating.toString(),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(widget.product?.name ?? '',
                        style: AppTextStyles.textStyle_500_14
                            .copyWith(color: AppTheme.colors.blackColor)),
                  ],
                ),
              ),
            ],
          ),
          // Wishlist Icon
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: () async {
                // Toggle the wishlist status locally
                setState(() {
                  _isWishlisted = !_isWishlisted;
                });

                print("widget.product?.id${widget.product?.id}");

                if (widget.product?.id != null) {
                  // Call the API to add/remove from wishlist
                  await homeViewModel.adRemoveWishlistApi(widget.product!.id.toString());

                  // Show appropriate snackbar based on the new state of _isWishlisted
                  if (_isWishlisted) {
                    showSnackBar(context, "Product added to favorites");
                  } else {
                    showSnackBar(context, "Product removed from favorites");
                  }
                } else {
                  showSnackBar(context, "Please try again later!!", isError: true);
                  print("Product ID is null, cannot add/remove from wishlist.");
                }

                print('Wishlist icon tapped for product: ${widget.product?.name}, isWishlisted: $_isWishlisted');
              },
              child: Icon(
                _isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: _isWishlisted ? AppTheme.colors.themeColor : Colors.grey,
                size: 24,
              ),
            ),
          )

        ],
      ),
    );
  }
}
