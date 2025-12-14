/// Interface for local storage operations
library local_storage_interface;

abstract class ILocalStorageService {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  
  Future<void> setStringList(String key, List<String> value);
  Future<List<String>?> getStringList(String key);
  
  Future<void> remove(String key);
  Future<void> clear();
  
  Future<bool> containsKey(String key);
}
