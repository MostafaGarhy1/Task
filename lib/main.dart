import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task/utils/langs/trans.dart';



import 'app_screen.dart';
import 'auth_state.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
   runApp(
    MyApp() ,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.blueGrey,
      ),
      home:StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges() ,
        builder:(ctx,snap){
          if(snap.hasData)
            return app_screen();
          else
            return auth_state();
        } ,
      ),
      translations: Transla() ,
      locale: Locale('ar'),
      fallbackLocale: Locale('ar'),
      );
  }
}
