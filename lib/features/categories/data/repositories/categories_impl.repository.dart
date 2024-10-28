import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/categories/data/repositories/categories.repository.dart';
import 'package:nomo_app/features/categories/data/sources/categories.source.dart';

class CategoriesImplRepository implements CategoriesRepository {
  CategoriesImplRepository({required CategoriesDataSource dataSource})
      : _dataSource = dataSource;

  final CategoriesDataSource _dataSource;

  @override
  Future<List<CategoryModel>?> getCategories(Params? params) async {
    try {
      List<CategoryModel>? categoriesModels =
          await _dataSource.getCategories(params);

      return categoriesModels;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
