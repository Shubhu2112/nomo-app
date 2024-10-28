import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';

abstract class HomeDataSource {
  Future<List<CategoryModel>?> getCategories(Params? params);
  Future<List<ProductModel>?> getBestSellingProducts(Params? params);
}
