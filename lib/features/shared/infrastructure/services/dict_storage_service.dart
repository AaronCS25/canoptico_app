abstract class DictStorageService {
  Future<void> save<T>(String key, T value);

  Future<T?> get<T>(String key);

  Future<bool> delete(String key);
}
