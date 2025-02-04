import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/core/services/location_services/location_service.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/features/authentication/data/models/user.model.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/dashboard/domain/usecase/home.usecase.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/store/data/models/store.model.dart';
import 'package:nomo_app/features/store/data/repositories/store_impl.repository.dart';
import 'package:nomo_app/features/store/data/sources/store_impl.source.dart';
import 'package:nomo_app/features/store/domain/store.usecase.dart';

class HomeCubit extends BaseCubit<
    (List<CategoryModel>?, List<ProductModel>?, StoreModel?)> {
  HomeCubit(super.context, {required this.homeUsecase});

  final HomeUsecase homeUsecase;
  List<CategoryModel>? _categories;
  List<ProductModel>? _bestSellingProducts;
  StoreModel? store;
  UserModel? userModel;
  Params bestSellingParams = Params();
  ScrollController scrollController = ScrollController();

  _fetchCategories() async {
    Params params = Params();
    params.andFilters.add(Filter(field: "enabled", values: ["true"]));
    params.sortFields.add(Sort(field: 'priority', order: "ASC"));
    final result = await homeUsecase.getCategories(params);
    _categories = result;
    // emit(BaseCompletedState(data: data));
  }

  _fetchBestSellingProducts({bool isInit = true}) async {
    if (isInit) {
      _initializeFetch();
    } else {
      _addShimmerLoading();
      bestSellingParams.page++;
    }

    try {
      final result =
          await homeUsecase.getBestSellingProducts(bestSellingParams);

      if (isInit) {
        _bestSellingProducts = result;
        isLoading = false;
      } else {
        _bestSellingProducts?.addAll(result ?? []);
        _removeShimmerLoading();
      }

      emit(BaseCompletedState(data: data));
    } catch (e) {
      emit(BaseErrorState(errorMessage: "Failed to fetch orders: $e"));
    }
  }

  void _initializeFetch() {
    isLoading = true;
    emit(const BaseLoadingState());
    _bestSellingProducts = [];
    bestSellingParams = Params();
    // params.limit = 4;

    bestSellingParams.andFilters
        .add(Filter(field: "subCategoryId", values: ["1"]));
  }

  void _addShimmerLoading() {
    final shimmerProduct = ProductModel(isLoading: true);
    for (int i = 0; i < 10; i++) {
      _bestSellingProducts?.add(shimmerProduct);
    }
    emit(BaseCompletedState(data: data));
  }

  void _removeShimmerLoading() {
    _bestSellingProducts?.removeWhere((order) => order.isLoading);
  }

  _getStore() async {
    if (context?.mounted ?? false) {
      Position? position = await LocationService.getCurrentPosition(context!);

      print(position?.latitude);
      print(position?.longitude);

      StoreUsecase storeUsecase = StoreUsecase(
        repository: StoreImplRepository(
          dataSource: StoreImplDataSource(httpService: ApiRestService()),
        ),
      );
      store = await storeUsecase.getStore(
          lat: "19.22241922639179", long: "73.16165912356324");
      // lat: position?.latitude.toString()??"0.0", long: position?.longitude.toString()??"0.0");
    }

    if (store == null) {
      emit(BaseErrorState(
          errorMessage: "Sorry,\nwe currently do not serve in your area."));
    }
  }

  void refreshData() {
    _fetchCategories();
    _fetchBestSellingProducts();
  }

  @override
  (List<CategoryModel>?, List<ProductModel>?, StoreModel?)? get data =>
      (_categories, _bestSellingProducts, store);

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) {
      emit(const BaseLoadingState());
      isLoading = true;
    }
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // if (!isLoading) {
        await _fetchBestSellingProducts(isInit: false);
        // }
      }
    });
    await _getStore();
    if (state is! BaseErrorState) {
      await _fetchCategories();
      await _fetchBestSellingProducts();
    }
    // if (!isDisposed) {
    //   emit(BaseCompletedState(data: data));
    // }
  }
}
