import 'dart:async';

import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_search/domain/product_search.usecase.dart';

class ProductSearchCubit extends BaseCubit<List<ProductModel>?> {
  ProductSearchCubit(
    super.context, {
    required this.productSearchUsecase,
  });

  final ProductSearchUsecase productSearchUsecase;

  List<ProductModel>? products;

  searchProducts(String query) async {
    isLoading = true;
    emit(const BaseLoadingState());
    products = [];
    Params params = Params();
    
    params.orFilters
        .add(Filter(field: "name", values: [query], condition: "\$contL"));
    params.orFilters.add(Filter(field: "aliases", values: [query],condition: "\$contL"));
    // params.andFilters
    //     .add(Filter(field: "enabled", values: ["true"], ));
    final result = await productSearchUsecase.getSearchProducts(params);
    products = result;
    isLoading = false;
    emit(BaseCompletedState(data: data));
  }

  @override
  List<ProductModel>? get data => products;

  @override
  FutureOr<void> init() async {
    emit(const BaseInitialState());
    // if (state is! BaseLoadingState) emit(const BaseLoadingState());
    // await fetchProducts(subCategoryId!);

    // if (!isDisposed) {
    //   emit(BaseCompletedState(data: data));
    // }
  }
}
