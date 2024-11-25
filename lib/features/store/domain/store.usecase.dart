import 'package:nomo_app/features/store/data/models/store.model.dart';
import 'package:nomo_app/features/store/data/repositories/store.repository.dart';

class StoreUsecase {
  final StoreRepository _repository;

  StoreUsecase({required StoreRepository repository})
      : _repository = repository;

  Future<StoreModel?> getStore({required String lat,required String long}) async {
    return await _repository.getNearbyStore(lat, long);
  }
}
