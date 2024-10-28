import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/categories/data/repositories/categories.repository.dart';

class CategoriesUsecase {
  final CategoriesRepository _repository;

  CategoriesUsecase({required CategoriesRepository repository}) : _repository = repository;

  Future<List<CategoryModel>?> getCategories(Params? params) async {
    return await _repository.getCategories(params);
  }
}
