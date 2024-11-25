import 'package:nomo_app/features/store/data/models/store.model.dart';

abstract class StoreDataSource {
  Future<StoreModel?> getNearbyStore(String lat, String long);
}
