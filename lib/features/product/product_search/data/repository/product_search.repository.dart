import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';

abstract class ProductSearchRepository {
  Future<List<ProductModel>?> getSearchProducts(Params? params);
}