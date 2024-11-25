import 'dart:async';

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
  StoreModel? _store;
  UserModel? userModel;

  _fetchCategories() async {
    Params params = Params();
    params.andFilters.add(Filter(field: "enabled", values: ["true"]));
    final result = await homeUsecase.getCategories(params);
    _categories = result;
    // emit(BaseCompletedState(data: data));
  }

  _fetchBestSellingProducts() async {
    Params params = Params();
    params.andFilters.add(Filter(field: "subCategoryId", values: ["1"]));
    final result = await homeUsecase.getBestSellingProducts(params);
    _bestSellingProducts = result;
    emit(BaseCompletedState(data: data));
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
      _store = await storeUsecase.getStore(
          lat: "19.22241922639179", long: "73.16165912356324");
      // lat: position?.latitude.toString()??"0.0", long: position?.longitude.toString()??"0.0");
    }

    if (_store == null) {
      emit(BaseErrorState(
          errorMessage: "Sorry,\nwe currently do not serve in your area."));
    }
  }

  @override
  (List<CategoryModel>?, List<ProductModel>?, StoreModel?)? get data =>
      (_categories, _bestSellingProducts, _store);

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
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
