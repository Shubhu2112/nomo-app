import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';

abstract class CategoriesDataSource {
  Future<List<CategoryModel>?> getCategories(Params? params);
}