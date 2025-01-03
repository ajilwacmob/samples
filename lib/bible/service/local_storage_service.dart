import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class LocalStorageService {
  static const String testmentKey = "testment_key";
  static const String bookIndexKey = "book_index_key";
  static const String chapterIndexKey = "chapter_index_key";
  static const String canSaveScrolledPositionKey = "can_save_scrolled_position_key";

  static Future<void> saveToLocalStorage(
      {required String key, required String value}) async {
    storage.write(key: key, value: value);
  }

  static Future<String> getSavedData({required String key}) async {
    return await storage.read(key: key) ?? "";
  }

    static Future<void> removeData({required String key}) async {
      storage.delete(key: key);
  }
}
