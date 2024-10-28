import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/dashboard/data/repositories/home.repository.dart';
import 'package:nomo_app/features/dashboard/data/sources/home.source.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';

class HomeImplRepository implements HomeRepository {
  HomeImplRepository({required HomeDataSource dataSource})
      : _dataSource = dataSource;

  final HomeDataSource _dataSource;

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

  @override
  Future<List<ProductModel>?> getBestSellingProducts(Params? params) async {
    try {
      List<ProductModel>? productsModels =
          await _dataSource.getBestSellingProducts(params);

      return productsModels;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
