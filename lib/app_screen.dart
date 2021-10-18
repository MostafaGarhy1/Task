

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/utils/langs/lang.dart';


import 'prep_screen/prep_stage.dart';
import 'prim_screen/primary_stage.dart';
import 'second_screen/sec_stage.dart';



class app_screen extends StatefulWidget {
   app_screen({key}) : super(key: key);

  @override
  State<app_screen> createState() => _app_screenState();
}

class _app_screenState extends State<app_screen> {
String _SelectedLang='en';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
              return  Text(snapshot.data!.data()!['username']);
            },
          ),
          backgroundColor: Colors.blueGrey,
          actions: [
             Row(
             children: [

               FlatButton(
                   onPressed:(){
                     showDialog(
                       context: context,
                       builder:(BuildContext context)=>AlertDialog(
                         title: Text("Are You Sure To Logout?".tr,style: TextStyle(fontWeight: FontWeight.bold)),
                         content: Row(
                           children: [
                             FlatButton(
                                 onPressed: ()=>FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pop(context),),
                                 child: Text("Ok".tr,style: TextStyle(fontWeight: FontWeight.bold),)),
                             SizedBox(width: 10,),
                             FlatButton(
                                 onPressed: ()=>Navigator.pop(context),
                                 child: Text("Close".tr,style: TextStyle(fontWeight: FontWeight.bold))),
                           ],

                         ),),);

                   },
                    child: Text("Logout".tr)),

               GetBuilder<AppLang>(
                   init: AppLang(),
                   builder: (controller){
                     return DropdownButton(
                       items: [
                         DropdownMenuItem(child: Text("en"),value: 'en',),
                         DropdownMenuItem(child: Text("ar"),value: 'ar',),
                       ],
                       value: controller.appLocal,
                       onChanged: (va){
                         controller.changeLanguage(va.toString());
                         Get.updateLocale(Locale(va.toString()));
                       },
                     );
                   }
               ),

             ],
           )
          ],
        ),
        body:Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage('assets/image.jpg'),fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
            child: Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Container(
                    width:double.infinity,
                    child: Text("Select The Stage...".tr,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black),),
                  ),
                   Padding(
                     padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/17),
                     child: Container(
                      color: Colors.black.withOpacity(0),
                      child: Column(
                         children: [
                          Container(
                            decoration: BoxDecoration(
                              
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            height: MediaQuery.of(context).size.height/6.5,
                            width: MediaQuery.of(context).size.height/4,
                             child: FlatButton(
                               textColor: Colors.black,
                               onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PrimaryStage())),
                               child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Primary\nStage".tr,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

                                ],
                            ),
                             ),),
                           SizedBox(height: MediaQuery.of(context).size.height/50,),
                           Container(
                             decoration: BoxDecoration(
                                 border: Border.all(color: Colors.black26),
                                 borderRadius: BorderRadius.circular(30),

                             ),
                             height: MediaQuery.of(context).size.height/6,
                             width: MediaQuery.of(context).size.height/4,
                              child: FlatButton(
                                textColor: Colors.black,
                                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PrepStage())),
                                child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Text("Prep\nStage".tr,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                 ],
                             ),
                              ),),
                           SizedBox(height: MediaQuery.of(context).size.height/50,),
                           Container(
                             decoration: BoxDecoration(
                                 border: Border.all(color: Colors.black26),
                                 borderRadius: BorderRadius.circular(30)
                             ),
                             height: MediaQuery.of(context).size.height/6,
                             width: MediaQuery.of(context).size.height/4,
                              child: FlatButton(
                                textColor: Colors.black,
                                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SecStage())),
                                child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Text("Secondary\nStage".tr,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                                 ],
                             ),
                              ),),
                             ],
                      ),
                  ),
                   ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}
