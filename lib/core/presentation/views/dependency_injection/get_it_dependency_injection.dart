import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/address/data/repositories/address.repository.dart';
import 'package:nomo_app/features/address/data/repositories/address_impl.repository.dart';
import 'package:nomo_app/features/address/data/sources/address.source.dart';
import 'package:nomo_app/features/address/data/sources/address_impl.source.dart';
import 'package:nomo_app/features/address/domain/usecase/address.usecase.dart';
import 'package:nomo_app/features/address/presentation/cubit/add_address.cubit.dart';
import 'package:nomo_app/features/address/presentation/cubit/address_list.cubit.dart';
import 'package:nomo_app/features/cart/data/repositories/cart.repository.dart';
import 'package:nomo_app/features/cart/data/repositories/cart_impl.repository.dart';
import 'package:nomo_app/features/cart/data/sources/cart.source.dart';
import 'package:nomo_app/features/cart/data/sources/cart_impl.source.dart';
import 'package:nomo_app/features/cart/domain/cart.usecase.dart';
import 'package:nomo_app/features/cart/presentation/cubit/cart.cubit.dart';
import 'package:nomo_app/features/categories/data/repositories/categories.repository.dart';
import 'package:nomo_app/features/categories/data/repositories/categories_impl.repository.dart';
import 'package:nomo_app/features/categories/data/sources/categories.source.dart';
import 'package:nomo_app/features/categories/data/sources/categories_impl.source.dart';
import 'package:nomo_app/features/categories/domain/usecase/categories.usecase.dart';
import 'package:nomo_app/features/categories/presentation/cubit/categories.cubit.dart';
import 'package:nomo_app/features/dashboard/data/repositories/home.repository.dart';
import 'package:nomo_app/features/dashboard/data/repositories/home_impl.repository.dart';
import 'package:nomo_app/features/dashboard/data/sources/home.source.dart';
import 'package:nomo_app/features/dashboard/data/sources/home_impl.source.dart';
import 'package:nomo_app/features/dashboard/domain/usecase/home.usecase.dart';
import 'package:nomo_app/features/dashboard/presentation/cubit/home.cubit.dart';
import 'package:nomo_app/features/order/data/repositories/order.repository.dart';
import 'package:nomo_app/features/order/data/repositories/order_impl.repository.dart';
import 'package:nomo_app/features/order/data/sources/order.source.dart';
import 'package:nomo_app/features/order/data/sources/order_impl.source.dart';
import 'package:nomo_app/features/order/domain/order.usecase.dart';
import 'package:nomo_app/features/order/presentation/cubits/order_status_timeline.cubit.dart';
import 'package:nomo_app/features/product/product_list/data/repository/product_list.repository.dart';
import 'package:nomo_app/features/product/product_list/data/repository/product_list_impl.repository.dart';
import 'package:nomo_app/features/product/product_list/data/sources/product_list_impl.dart';
import 'package:nomo_app/features/product/product_list/domain/product_list.usecase.dart';
import 'package:nomo_app/features/product/product_list/presentation/cubit/product_list.cubit.dart';
import 'package:nomo_app/features/product/product_search/data/repository/product_search.repository.dart';
import 'package:nomo_app/features/product/product_search/data/repository/product_search_impl.repository.dart';
import 'package:nomo_app/features/product/product_search/data/sources/product_search.source.dart';
import 'package:nomo_app/features/product/product_search/data/sources/product_search_impl.source.dart';
import 'package:nomo_app/features/product/product_search/domain/product_search.usecase.dart';
import 'package:nomo_app/features/product/product_search/presentation/cubit/product_search.cubit.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup(BuildContext context) {
    _registerCoreServices();
    _registerFeatures(context);
  }

  // Core Services
  static void _registerCoreServices() {
    if (!getIt.isRegistered<HttpService>()) {
      getIt.registerLazySingleton<HttpService>(() => ApiRestService());
    }
  }

  // Feature Modules
  static void _registerFeatures(BuildContext context) {
    try {
      // Home
      getIt.registerLazySingleton<HomeDataSource>(
          () => HomeImplDataSource(httpService: getIt()));
      getIt.registerLazySingleton<HomeRepository>(
          () => HomeImplRepository(dataSource: getIt()));
      getIt.registerLazySingleton(() => HomeUsecase(repository: getIt()));
      getIt.registerLazySingleton(
          () => HomeCubit(context, homeUsecase: getIt()));

      // Categories
      getIt.registerLazySingleton<CategoriesDataSource>(
          () => CategoriesImplDataSource(httpService: getIt()));
      getIt.registerLazySingleton<CategoriesRepository>(
          () => CategoriesImplRepository(dataSource: getIt()));
      getIt.registerLazySingleton(() => CategoriesUsecase(repository: getIt()));
      getIt.registerLazySingleton(
          () => CategoriesCubit(context, categoriesUsecase: getIt()));

      // Product List
      getIt.registerLazySingleton<ProductListImplDataSource>(
          () => ProductListImplDataSource(httpService: getIt()));
      getIt.registerLazySingleton<ProductListRepository>(
          () => ProductListImplRepository(dataSource: getIt()));
      getIt
          .registerLazySingleton(() => ProductListUsecase(repository: getIt()));
      getIt.registerLazySingleton(
          () => ProductListCubit(context, productListUsecase: getIt()));

      // prodyuct search
      getIt.registerLazySingleton<ProductSearchDataSource>(
          () => ProductSearchImplDataSource(httpService: getIt()));
      getIt.registerLazySingleton<ProductSearchRepository>(
          () => ProductSearchImplRepository(dataSource: getIt()));
      getIt
          .registerLazySingleton(() => ProductSearchUsecase(repository: getIt()));
      getIt.registerLazySingleton(
          () => ProductSearchCubit(context, productSearchUsecase: getIt()));

      // Address
      getIt.registerLazySingleton<AddressDataSource>(
          () => AddressImplDataSource(httpService: getIt()));
      getIt.registerLazySingleton<AddressRepository>(
          () => AddressImplRepository(dataSource: getIt()));
      getIt.registerLazySingleton(() => AddressUsecase(repository: getIt()));
      getIt.registerLazySingleton(
          () => AddressListCubit(context, addressUsecase: getIt())..init());
      getIt.registerLazySingleton(
          () => AddAddressCubit(context, addressUsecase: getIt()));

      // Order
      getIt.registerLazySingleton<OrderDataSource>(
          () => OrderImplDataSource(httpService: getIt()));
      getIt.registerLazySingleton<OrderRepository>(
          () => OrderImplRepository(dataSource: getIt()));
      getIt.registerLazySingleton(() => OrderUsecase(repository: getIt()));
      getIt.registerLazySingleton(
          () => OrderStatusTimelineCubit(context)..init());

      // Cart
      getIt.registerLazySingleton<CartDataSource>(
          () => CartImplDataSource(httpService: getIt()));
      getIt.registerLazySingleton<CartRepository>(
          () => CartImplRepository(dataSource: getIt()));
      getIt.registerLazySingleton(() => CartUsecase(repository: getIt()));
      debugPrint("CartUsecase registered successfully");
      getIt.registerLazySingleton(() => CartCubit(
            context,
            cartUsecase: getIt<CartUsecase>(),
            orderUsecase: getIt<OrderUsecase>(),
          ));

      // getIt.registerFactory<SubCategoriesImplDataSource>(
      //     () => SubCategoriesImplDataSource(httpService: getIt()));
      // getIt.registerFactory<SubCategoriesRepository>(
      //     () => SubCategoriesImplRepository(dataSource: getIt()));
      // getIt.registerFactory(() => SubCategoriesUsecase(repository: getIt()));
      // getIt.registerFactoryParam<SubCategoriesCubit, BuildContext, String>(
      //   (context, categoryId) => SubCategoriesCubit(
      //     context,
      //     categoryId: categoryId,
      //     subCategoriesUsecase: getIt(),
      //   ),
      // );
    } catch (e) {
      print(e);
    }
  }
}
