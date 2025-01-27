import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/sources/product_list_impl.dart';
import 'package:nomo_app/features/product/product_search/data/repository/product_search.repository.dart';
class ProductSearchImplRepository implements ProductSearchRepository {
  ProductSearchImplRepository({required ProductListImplDataSource dataSource})
      : _dataSource = dataSource;

  final ProductListImplDataSource _dataSource;

  

  @override
  Future<List<ProductModel>?> getSearchProducts(Params? params) async{
    try {
      List<ProductModel>? productModels =
          await _dataSource.getProducts(params);

      return productModels;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
