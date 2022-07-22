import 'package:get_storage/get_storage.dart';

const token = 'TOKEN';

class StorageService {
  final box = GetStorage();
  init() async {
    await GetStorage.init();
  }

  write(String key, String value) {
    box.write(token, value);
  }

  read(String key) {
    return box.read(key);
  }

  clearStorage() async{
   await box.erase();
  }
}
final storageService = StorageService();
