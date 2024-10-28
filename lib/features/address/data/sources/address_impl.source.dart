import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';
import 'package:nomo_app/features/address/data/sources/address.source.dart';

class AddressImplDataSource implements AddressDataSource {
  AddressImplDataSource({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<List<AddressModel>?> getAddresses(Params? params) async {
    final apiResponse = await _httpService.handleGetRequestList(
      ApiConstants.addresses,
      params: params,
      isPublic: false,
    );

    List<AddressModel>? response;
    try {
      response = apiResponse?.data
          ?.map(
            (e) => AddressModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }

    return response;
  }

  @override
  Future<AddressModel?> addAddress(AddressModel address) async {
    final apiResponse = await _httpService.handlePostRequest(
      ApiConstants.addresses,
      address.toJson(),
      isPublic: false,
    );

    AddressModel? response;
    try {
      response = AddressModel.fromJson(apiResponse?.data ?? {});
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
