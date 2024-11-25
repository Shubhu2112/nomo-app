import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/features/store/data/models/store.model.dart';
import 'package:nomo_app/features/store/data/repositories/store.repository.dart';
import 'package:nomo_app/features/store/data/sources/store.source.dart';

class StoreImplRepository implements StoreRepository {
  StoreImplRepository({required StoreDataSource dataSource})
      : _dataSource = dataSource;

  final StoreDataSource _dataSource;

  @override
  Future<StoreModel?> getNearbyStore(String lat, String long) async {
    try {
      StoreModel? orderModel = await _dataSource.getNearbyStore(lat,long);

      return orderModel;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
