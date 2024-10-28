import 'dart:async';

import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/authentication/data/models/user.model.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/dashboard/domain/usecase/home.usecase.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';

class HomeCubit extends BaseCubit<(List<CategoryModel>?, List<ProductModel>?)> {
  HomeCubit(super.context, {required this.homeUsecase});

  final HomeUsecase homeUsecase;
  List<CategoryModel>? _categories;
  List<ProductModel>? _bestSellingProducts;
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
    params.andFilters.add(Filter(field: "subCategoryId", values: ["4"]));
    final result = await homeUsecase.getBestSellingProducts(params);
    _bestSellingProducts = result;
    emit(BaseCompletedState(data: data));
  }

  @override
  (List<CategoryModel>?, List<ProductModel>?)? get data =>
      (_categories, _bestSellingProducts);

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    await _fetchCategories();
    await _fetchBestSellingProducts();
    // if (!isDisposed) {
    //   emit(BaseCompletedState(data: data));
    // }
  }
}
