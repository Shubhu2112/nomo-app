import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nomo_app/core/presentation/app_theme/app_theme.dart';
import 'package:nomo_app/core/presentation/views/dependency_injection/get_it_dependency_injection.dart';
import 'package:nomo_app/core/presentation/views/splash.view.dart';
import 'package:nomo_app/core/services/bloc_services/bloc_manager.dart';
import 'package:nomo_app/core/services/flavor_services/repositories/flavor_impl.repository.dart';
import 'package:nomo_app/core/services/flavor_services/sources/asset_flavor_impl.source.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/core/services/notification_services/notification.service.dart';
import 'package:nomo_app/core/services/offline_db_services/hive.service.dart';
import 'package:nomo_app/features/address/data/repositories/address_impl.repository.dart';
import 'package:nomo_app/features/address/data/sources/address_impl.source.dart';
import 'package:nomo_app/features/address/domain/usecase/address.usecase.dart';
import 'package:nomo_app/features/address/presentation/cubit/add_address.cubit.dart';
import 'package:nomo_app/features/address/presentation/cubit/address_list.cubit.dart';
import 'package:nomo_app/features/cart/data/repositories/cart_impl.repository.dart';
import 'package:nomo_app/features/cart/data/sources/cart_impl.source.dart';
import 'package:nomo_app/features/cart/presentation/cubit/cart.cubit.dart';
import 'package:nomo_app/features/categories/data/repositories/categories_impl.repository.dart';
import 'package:nomo_app/features/categories/data/sources/categories_impl.source.dart';
import 'package:nomo_app/features/categories/domain/usecase/categories.usecase.dart';
import 'package:nomo_app/features/categories/presentation/cubit/categories.cubit.dart';
import 'package:nomo_app/features/dashboard/data/repositories/home_impl.repository.dart';
import 'package:nomo_app/features/dashboard/data/sources/home_impl.source.dart';
import 'package:nomo_app/features/dashboard/domain/usecase/home.usecase.dart';
import 'package:nomo_app/features/dashboard/presentation/cubit/home.cubit.dart';
import 'package:nomo_app/features/order/data/repositories/order_impl.repository.dart';
import 'package:nomo_app/features/order/data/sources/order_impl.source.dart';
import 'package:nomo_app/features/order/domain/order.usecase.dart';
import 'package:nomo_app/features/order/presentation/cubits/order_status_timeline.cubit.dart';
import 'package:nomo_app/features/product/product_list/data/repository/product_list_impl.repository.dart';
import 'package:nomo_app/features/product/product_list/data/sources/product_list_impl.dart';
import 'package:nomo_app/features/product/product_list/domain/product_list.usecase.dart';
import 'package:nomo_app/features/product/product_list/presentation/cubit/product_list.cubit.dart';
import 'package:nomo_app/features/product/product_search/presentation/cubit/product_search.cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeFCM();
  await HiveService().init();
  await FlavorRepositoryImpl(dataSource: AssetFlavorDataSource())
      .loadAppConfiguration();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return Builder(
      builder: (context) {
         ServiceLocator.setup(context);
        return MultiBlocProvider(
         providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<CategoriesCubit>()),
        BlocProvider(create: (context) => getIt<ProductListCubit>()),
           BlocProvider(create: (context) => getIt<ProductSearchCubit>()),
        BlocProvider(create: (context) => getIt<AddressListCubit>()),
        BlocProvider(create: (context) => getIt<AddAddressCubit>()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
        BlocProvider(create: (context) => getIt<OrderStatusTimelineCubit>()),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme.buildTheme(context),
            // navigatorKey: NavigationService.navigatorKey,
            routes: NavigationService.generateRoute(),
            debugShowCheckedModeBanner: false,
            //  navigatorObservers: [CustomNavigatorObserver()],
            home: SplashView(),
          ),
        );
      }
    );
  }
}
