import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';
import 'package:nomo_app/features/address/data/repositories/address.repository.dart';
import 'package:nomo_app/features/address/data/sources/address.source.dart';

class AddressImplRepository implements AddressRepository {
  AddressImplRepository({required AddressDataSource dataSource})
      : _dataSource = dataSource;

  final AddressDataSource _dataSource;

  @override
  Future<List<AddressModel>?> getAddresses(Params? params) async {
    try {
      List<AddressModel>? addressModels =
          await _dataSource.getAddresses(params);

      return addressModels;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
  
  @override
  Future<AddressModel?> addAddress(AddressModel address) async{
    try {
      AddressModel? addressModels =
          await _dataSource.addAddress(address);

      return addressModels;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
