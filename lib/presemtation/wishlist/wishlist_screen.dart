import 'dart:async'; // Import dart:async for Timer

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:product_listing_app/presemtation/home/viemodel/home_view_model.dart';
import 'package:product_listing_app/theme/app_theme.dart';
import 'package:product_listing_app/theme/text_styles.dart';
import 'package:product_listing_app/widgets/common_button.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  WishlistScreenState createState() => WishlistScreenState();
}

class WishlistScreenState extends State<WishlistScreen> {
  late HomeViewModel homeViewModel;


  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    getWishLists();

  }
  Future<void> getWishLists() async {
    final homeViewModel =
    Provider.of<HomeViewModel>(context, listen: false);
    await homeViewModel.getWishLists();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Wishlist",
              style: AppTextStyles.textStyle_500_18.copyWith(
                color: AppTheme.colors.blackColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: homeViewModel.isWishListLoading
                  ? Center(
                child:  CupertinoActivityIndicator(
                  color: AppTheme.colors.themeColor,
                  animating: true,
                ),
              )
                  : homeViewModel.wishLists!.isEmpty
                  ?  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/no_wish_list.png",width: width * 0.4,),
                        Gap(10),
                        Text("No wishlist found",style: AppTextStyles.textStyle_700_12
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
                itemCount: homeViewModel.wishLists?.length,
                itemBuilder: (context, index) {
                  final product = homeViewModel.wishLists?[index];
                  final num mrp =
                  product?.mrp is num ? product?.mrp as num : 0;
                  final num discount = product?.discount is num
                      ? product?.discount as num
                      : num.tryParse(
                      product?.discount.toString() ?? '0') ??
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
  bool _isWishlisted = true; //  Initial state: not wishlisted

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
              onTap: () {
                //  Toggle the wishlist status locally
                setState(() {
                  setState(() async {
                    _isWishlisted = !_isWishlisted;
                    print("widget.product?.id${widget.product?.id}");
                    if (widget.product?.id != null) {
                      await homeViewModel.adRemoveWishlistApi(widget.product!.id.toString());
                      showSnackBar(context,"Product removed from favorites");
                      await homeViewModel.getWishLists();
                    } else {
                      showSnackBar(context,"Please try again later!!",isError: true);
                      print(
                          "Product ID is null, cannot add/remove from wishlist.");
                    }
                  });

                });
                //  Here, you would also call your homeViewModel to
                //  persist the wishlist change (add/remove from database, etc.)
                //  homeViewModel.toggleWishlist(widget.product);
                print(
                    'Wishlist icon tapped for product: ${widget.product?.name}, isWishlisted: $_isWishlisted');
              },
              child: Icon(
                _isWishlisted ? Icons.favorite : Icons.favorite_border,
                // Choose icon based on state
                color: _isWishlisted ? AppTheme.colors.themeColor : Colors.grey,
                // Change color based on state
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
