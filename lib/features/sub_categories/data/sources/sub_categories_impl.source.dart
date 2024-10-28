import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/sub_categories/data/models/sub_categories.model.dart';
import 'package:nomo_app/features/sub_categories/data/sources/sub_categories.source.model.dart';

class SubCategoriesImplDataSource implements SubCategoriesSource {
  SubCategoriesImplDataSource({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<List<SubCategoryModel>?> getSubCategories(Params? params) async {
    final apiResponse = await _httpService.handleGetRequestList(
      ApiConstants.subCategories,
      params: params,
      isPublic: true,
    );

    List<SubCategoryModel>? response;
    try {
      response = apiResponse?.data
          ?.map(
            (e) => SubCategoryModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
