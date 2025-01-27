import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/product/product_list/presentation/cubit/product_list.cubit.dart';
import 'package:nomo_app/features/sub_categories/data/models/sub_categories.model.dart';
import 'package:nomo_app/features/sub_categories/domain/usecase/sub_categories.usecase.dart';

class SubCategoriesCubit extends BaseCubit<List<SubCategoryModel>?> {
  SubCategoriesCubit(super.context,
      {required this.subCategoriesUsecase, required this.categoryId});

  final SubCategoriesUsecase subCategoriesUsecase;
  final String? categoryId;
  SubCategoryModel? selectedSubcategory;
  List<SubCategoryModel>? subCategories;

  _fetchSubCategories() async {
    Params params = Params();
    params.limit = 30;
    params.andFilters.add(Filter(field: "categoryId", values: [categoryId!]));
    params.andFilters.add(Filter(field: "enabled", values: ["true"]));
    final result = await subCategoriesUsecase.getSubCategories(params);
    subCategories = result;
    if (subCategories?.isNotEmpty ?? false) {
      subCategories!.first = subCategories!.first.copyWith(isSelected: true);
      selectedSubcategory = subCategories!.first;
    }
    emit(BaseCompletedState(data: data));
    if (selectedSubcategory != null) {
      context!
          .read<ProductListCubit>()
          .fetchProducts(subCategoryId: selectedSubcategory!.id!.toString());
    }
  }

  void updateSubCategorySelection(int index) {
    // Deselect all categories
    subCategories = subCategories?.map((subCategory) {
      return subCategory.copyWith(isSelected: false);
    }).toList();

    // Select the tapped category
    if (subCategories != null && index >= 0 && index < subCategories!.length) {
      subCategories![index] = subCategories![index].copyWith(isSelected: true);
      selectedSubcategory = subCategories![index];
    }

    // Emit a new state to trigger a rebuild
    emit(BaseCompletedState(data: data));
    if (selectedSubcategory != null) {
      context!
          .read<ProductListCubit>()
          .fetchProducts(subCategoryId: selectedSubcategory!.id!.toString());
    }
  }

  @override
  List<SubCategoryModel>? get data => subCategories;

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    await _fetchSubCategories();

    // if (!isDisposed) {
    //   emit(BaseCompletedState(data: data));
    // }
  }
}
