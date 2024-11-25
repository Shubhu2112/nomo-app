import 'package:nomo_app/features/store/data/models/store.model.dart';

abstract class StoreRepository {
  Future<StoreModel?> getNearbyStore(String lat, String long);
}
