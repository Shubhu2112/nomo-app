import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';
import 'package:nomo_app/features/address/data/repositories/address.repository.dart';

class AddressUsecase {
  final AddressRepository _repository;

  AddressUsecase({required AddressRepository repository})
      : _repository = repository;

  Future<List<AddressModel>?> getAddressses(Params? params) async {
    return await _repository.getAddresses(params);
  }

   Future<AddressModel?> addAddresss(AddressModel address) async {
    return await _repository.addAddress(address);
  }
}
