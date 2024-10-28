import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/sub_categories/data/models/sub_categories.model.dart';
import 'package:nomo_app/features/sub_categories/data/repositories/sub_categories.repository.dart';

class SubCategoriesUsecase {
  final SubCategoriesRepository _repository;

  SubCategoriesUsecase({required SubCategoriesRepository repository}) : _repository = repository;

  Future<List<SubCategoryModel>?> getSubCategories(Params? params) async {
    return await _repository.getSubCategories(params);
  }
}
