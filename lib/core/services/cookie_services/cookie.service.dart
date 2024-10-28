import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CookieService {
 static const _storage = FlutterSecureStorage();

  // Save data to secure storage
  static Future<void> storeData({
    required String key,
    required String? value,
  }) async {
    if (value != null) {
      await _storage.write(key: key, value: value);
    }
  }

  // Load data from secure storage
  static Future<String?> retrieveData(String key) async {
    return await _storage.read(key: key);
  }

  // Delete data from secure storage
  static Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }

  // Check if data exists in secure storage
  static Future<bool> hasData(String key) async {
    return await _storage.containsKey(key: key);
  }
}
