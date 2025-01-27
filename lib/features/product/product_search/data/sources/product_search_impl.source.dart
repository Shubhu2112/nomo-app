import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_search/data/sources/product_search.source.dart';

class ProductSearchImplDataSource implements ProductSearchDataSource {
  ProductSearchImplDataSource({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<List<ProductModel>?> getSearchProducts(Params? params) async {
    final apiResponse = await _httpService.handleGetRequestList(
      ApiConstants.products,
      params: params,
      isPublic: true,
    );

    List<ProductModel>? response;
    try {
      response = apiResponse?.data
          ?.map(
            (e) => ProductModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
