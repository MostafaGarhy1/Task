import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/utils/langs/local_storage.dart';

class AppLang extends GetxController{
  var appLocal='ar';
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    LocalStorage localStorage=LocalStorage();

    appLocal=await localStorage.languageSelected == null?'ar':await localStorage.languageSelected ;
    Get.updateLocale(Locale(appLocal));
    update();
  }
  void changeLanguage(String type)async{
    LocalStorage localStorage=LocalStorage();
    if(appLocal==type){
      return;
    }
    if(type=='ar'){
      appLocal='ar';
      localStorage.saveLanguageToDisk('ar');
    }else{
      appLocal='en';
      localStorage.saveLanguageToDisk('en');
    }
    update();

  }
}