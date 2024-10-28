import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/sub_categories/data/models/sub_categories.model.dart';
import 'package:nomo_app/features/sub_categories/data/repositories/sub_categories.repository.dart';
import 'package:nomo_app/features/sub_categories/data/sources/sub_categories_impl.source.dart';

class SubCategoriesImplRepository implements SubCategoriesRepository {
  SubCategoriesImplRepository({required SubCategoriesImplDataSource dataSource})
      : _dataSource = dataSource;

  final SubCategoriesImplDataSource _dataSource;

  @override
  Future<List<SubCategoryModel>?> getSubCategories(Params? params) async {
    try {
      List<SubCategoryModel>? subCategoriesModels =
          await _dataSource.getSubCategories(params);

      return subCategoriesModels;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
