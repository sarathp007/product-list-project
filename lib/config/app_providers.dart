
import 'package:http/http.dart' as http;
import 'package:product_listing_app/core/constants.dart';
import 'package:product_listing_app/data/remote/api/auth_api.dart';
import 'package:product_listing_app/data/remote/api/product_list_api.dart';
import 'package:product_listing_app/data/repository/auth/auth_repository.dart';
import 'package:product_listing_app/data/repository/product_list/product_list_repository.dart';
import 'package:product_listing_app/data/usecase/auth/auth_use_case.dart';
import 'package:product_listing_app/data/usecase/product_list/product_list_use_case.dart';
import 'package:product_listing_app/presemtation/home/viemodel/home_view_model.dart';
import 'package:product_listing_app/presemtation/login/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

import '../main.dart';


MultiProvider appProviders() {
  final http.Client client = http.Client();

  return MultiProvider(
    providers:  [
       //Provider<http.Client>.value(value: client),


      Provider<AuthApi>(
        create: (_) => AuthApi(
          baseUrl: baseUrl,
          client: client,
        ),
      ),
      Provider<AuthRepository>(
        create: (context) => AuthRepository(
          api: Provider.of<AuthApi>(context, listen: false),
        ),
      ),
      Provider<AuthUseCase>(
        create: (context) => AuthUseCase(
          repository: Provider.of<AuthRepository>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(
          useCase: Provider.of<AuthUseCase>(context, listen: false),
        ),
      ),

      Provider<ProductListApi>(
        create: (_) => ProductListApi(
          baseUrl: baseUrl,
          client: client,
        ),
      ),
      Provider<ProductListRepository>(
        create: (context) => ProductListRepository(
          api: Provider.of<ProductListApi>(context, listen: false),
        ),
      ),
      Provider<ProductListUseCase>(
        create: (context) => ProductListUseCase(
          repository: Provider.of<ProductListRepository>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(
          useCase: Provider.of<ProductListUseCase>(context, listen: false),
        ),
      ),
    ],
    child: const MyApp(),
  );
}