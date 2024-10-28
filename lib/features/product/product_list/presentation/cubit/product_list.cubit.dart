import 'dart:async';

import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/domain/product_list.usecase.dart';

class ProductListCubit extends BaseCubit<List<ProductModel>?> {
  ProductListCubit(super.context,
      {required this.productListUsecase, });

  final ProductListUsecase productListUsecase;

  List<ProductModel>? products;

  fetchProducts(String subCategoryId) async {
    emit(const BaseLoadingState());
    products = [];
    Params params = Params();
    params.andFilters
        .add(Filter(field: "subCategoryId", values: [subCategoryId]));
    params.andFilters.add(Filter(field: "enabled", values: ["true"]));
    final result = await productListUsecase.getProducts(params);
    products = result;

    emit(BaseCompletedState(data: data));
  }

  @override
  List<ProductModel>? get data => products;

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    // await fetchProducts(subCategoryId!);

    // if (!isDisposed) {
    //   emit(BaseCompletedState(data: data));
    // }
  }
}
