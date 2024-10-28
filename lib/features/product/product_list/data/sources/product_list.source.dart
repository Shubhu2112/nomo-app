import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';

abstract class ProductListDataSource {
  Future<List<ProductModel>?> getProducts(Params? params);
}