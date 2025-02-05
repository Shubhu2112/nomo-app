import 'dart:async';

import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/categories/domain/usecase/categories.usecase.dart';

class CategoriesCubit extends BaseCubit<List<CategoryModel>> {
  CategoriesCubit(super.context, {required this.categoriesUsecase});

  final CategoriesUsecase categoriesUsecase;
  List<CategoryModel>? _categories;

  List<CategoryModel> groceryCategories = [];
  List<CategoryModel> snacksCategories = [];
  List<CategoryModel> beautyCategories = [];
  List<CategoryModel> householdCategories = [];

  _fetchCategories() async {
    Params params = Params();
    params.limit = 30;
    params.andFilters
        .add(Filter(field: "priority", values: ["1", "2", "3", "4"]));
    params.andFilters.add(Filter(field: "enabled", values: ["true"]));
    final result = await categoriesUsecase.getCategories(params);
    _categories = result;
    groceryCategories.addAll(_categories
            ?.where(
              (element) => element.priority == 1,
            )
            .toList() ??
        []);
    snacksCategories.addAll(_categories
            ?.where(
              (element) => element.priority == 2,
            )
            .toList() ??
        []);
    beautyCategories.addAll(_categories
            ?.where(
              (element) => element.priority == 3,
            )
            .toList() ??
        []);
    householdCategories.addAll(_categories
            ?.where(
              (element) => element.priority == 4,
            )
            .toList() ??
        []);
    emit(BaseCompletedState(data: data));
  }

  void refreshData() {
    groceryCategories = [];
    snacksCategories = [];
    beautyCategories = [];
    householdCategories = [];
    if (groceryCategories.isEmpty &&
        snacksCategories.isEmpty &&
        beautyCategories.isEmpty &&
        householdCategories.isEmpty) {
      _fetchCategories();
    }
  }

  @override
  List<CategoryModel>? get data => _categories;

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    await _fetchCategories();

    // if (!isDisposed) {
    //   emit(BaseCompletedState(data: data));
    // }
  }
}
