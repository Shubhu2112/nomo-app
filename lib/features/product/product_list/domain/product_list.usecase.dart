import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/repository/product_list.repository.dart';

class ProductListUsecase {
  final ProductListRepository _repository;

  ProductListUsecase({required ProductListRepository repository}) : _repository = repository;

  Future<List<ProductModel>?> getProducts(Params? params) async {
    return await _repository.getProducts(params);
  }
}
