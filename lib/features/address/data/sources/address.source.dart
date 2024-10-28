import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';

abstract class AddressDataSource {
  Future<List<AddressModel>?> getAddresses(Params? params);

   Future<AddressModel?> addAddress(AddressModel address);
}