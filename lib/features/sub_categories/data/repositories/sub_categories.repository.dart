import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/sub_categories/data/models/sub_categories.model.dart';

abstract class SubCategoriesRepository {
  Future<List<SubCategoryModel>?> getSubCategories(Params? params);
}