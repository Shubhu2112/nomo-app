import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/flavor_services/sources/flavor.source.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';

class FlavorDataSourceImpl implements FlavorDataSource {
  FlavorDataSourceImpl({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<Map<String, dynamic>?> getAppConfiguration() async {
    final apiResponse =
        await _httpService.handleGetRequest(ApiConstants.appConfig);
    return apiResponse?.data;
  }
}
