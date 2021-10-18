import 'package:get_storage/get_storage.dart';

class LocalStorage {
  void saveLanguageToDisk (String langusage)async{
    await GetStorage().write('lang', langusage);
  }
  Future<String> get languageSelected async{
    return await GetStorage().read('lang');
  }

}