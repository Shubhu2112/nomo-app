import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/store/data/models/store.model.dart';
import 'package:nomo_app/features/store/data/sources/store.source.dart';

class StoreImplDataSource implements StoreDataSource {
  StoreImplDataSource({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<StoreModel?> getNearbyStore(String lat, String long) async {
    final apiResponse = await _httpService.handleGetRequest(
      ApiConstants.storeNearby,
      queryParameters: {"lat": lat, "long": long},
      isPublic: true,
    );

    StoreModel? response;
    try {
      if (apiResponse?.data?.isNotEmpty ?? false) {
        response = StoreModel.fromJson(apiResponse?.data ?? {});
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }
}
