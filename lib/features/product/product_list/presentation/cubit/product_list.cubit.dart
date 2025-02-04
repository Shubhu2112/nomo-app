import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/domain/product_list.usecase.dart';

class ProductListCubit extends BaseCubit<List<ProductModel>?> {
  ProductListCubit(
    super.context, {
    required this.productListUsecase,
  });

  final ProductListUsecase productListUsecase;

  List<ProductModel>? products;
  Params params = Params();
  String? subCategory;
  ScrollController scrollController = ScrollController();

  Future<void> fetchProducts(
      {String? subCategoryId, bool isInit = true}) async {
    if (isInit) {
      _initializeFetch(subCategoryId);
    } else {
      _addShimmerLoading();
      params.page++;
    }

    final result = await productListUsecase.getProducts(params);

    if (isInit) {
      products = result;
      isLoading = false;
    } else {
      products?.addAll(result ?? []);
      _removeShimmerLoading();
    }
    emit(BaseCompletedState(data: data));
  }

  void _initializeFetch(String? subCategoryId) {
    isLoading = true;
    subCategory = subCategoryId;
    emit(const BaseLoadingState());
    products = [];
    params = Params();
    params.andFilters
        .add(Filter(field: "subCategoryId", values: [subCategory ?? ""]));
    params.andFilters.add(Filter(field: "enabled", values: ["true"]));
  }

  void _addShimmerLoading() {
    ProductModel temp = ProductModel().copyWith(isLoading: true);
    for (int i = 0; i < 10; i++) {
      products?.add(temp);
    }
    emit(BaseCompletedState(data: data));
  }

  void _removeShimmerLoading() {
    products?.removeWhere((product) => product.isLoading);
  }

  void refreshData() {
    fetchProducts(subCategoryId: subCategory,isInit: true);
  }

  @override
  List<ProductModel>? get data => products;

  @override
  FutureOr<void> init() async {
    emit(const BaseInitialState());

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await fetchProducts(isInit: false);
      }
    });
  }
}
