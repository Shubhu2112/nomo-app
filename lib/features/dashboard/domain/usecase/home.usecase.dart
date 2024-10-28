import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/dashboard/data/repositories/home.repository.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';

class HomeUsecase {
  final HomeRepository _repository;

  HomeUsecase({required HomeRepository repository}) : _repository = repository;

  Future<List<CategoryModel>?> getCategories(Params? params) async {
    return await _repository.getCategories(params);
  }

   Future<List<ProductModel>?> getBestSellingProducts(Params? params) async {
    return await _repository.getBestSellingProducts(params);
  }
}
