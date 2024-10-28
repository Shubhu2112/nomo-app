import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/categories/data/models/categories.model.dart';
import 'package:nomo_app/features/categories/data/sources/categories.source.dart';

class CategoriesImplDataSource implements CategoriesDataSource {
  CategoriesImplDataSource({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<List<CategoryModel>?> getCategories(Params? params) async {
    final apiResponse = await _httpService.handleGetRequestList(
      ApiConstants.categories,
      params: params,
      isPublic: true,
    );

    List<CategoryModel>? response;
    try {
      response = apiResponse?.data
          ?.map(
            (e) => CategoryModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
