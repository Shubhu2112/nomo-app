import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/repository/product_list.repository.dart';
import 'package:nomo_app/features/product/product_search/data/repository/product_search.repository.dart';

class ProductSearchUsecase {
  final ProductSearchRepository _repository;

  ProductSearchUsecase({required ProductSearchRepository repository}) : _repository = repository;

  Future<List<ProductModel>?> getSearchProducts(Params? params) async {
    return await _repository.getSearchProducts(params);
  }
}
