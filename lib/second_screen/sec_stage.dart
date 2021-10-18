import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'show_sec.dart';
class SecStage extends StatefulWidget {
  const SecStage({Key? key}) : super(key: key);

  @override
  _SecStageState createState() => _SecStageState();
}

class _SecStageState extends State<SecStage> {
  TextEditingController _Con2 = TextEditingController();

  _AddClass(){
    showDialog(
        context: context,
        builder:(BuildContext context)=>AlertDialog(
          title: Text("Add Class".tr),
          content: Column(
            children: [
              Container(
                child: TextField(
                  controller: _Con2,
                  decoration: InputDecoration(
                      labelText: "Enter The Class Name".tr
                  ),
                ),
              ),
              FlatButton(
                onPressed: (){
                  FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('Classes2').doc(_Con2.text).set({
                    'title2': _Con2.text,
                    'time2':DateTime.now().day-1,
                  }).whenComplete(() => Navigator.pop(context));
                },
                child:  Icon(Icons.add),),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Secondary Stage".tr,style: TextStyle(color: Colors.black),),
          leading:FlatButton(
            onPressed: ()=>Navigator.pop(context),
            child: Icon(Icons.chevron_left),
          ) ,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('Classes2').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.hasData?snapshot.data!.docs.length:0,
                itemBuilder: (ctx,index){
                  return  Card(
                    child: ListTile(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSec(ShowClass: snapshot.data!.docs[index]))),
                      title: Text(snapshot.data!.docs[index].data()['title2'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:(BuildContext context)=>AlertDialog(
                                title: Text("Are You Sure To Delete The Class?".tr),
                                content: Row(
                                  children: [
                                    FlatButton(
                                        onPressed: (){
                                          snapshot.data!.docs[index].reference.delete().whenComplete(() => Navigator.pop(context));
                                        },
                                        child: Text("Ok".tr)),
                                    FlatButton(
                                        onPressed: ()=>Navigator.pop(context),
                                        child: Text("Close".tr)),
                                  ],

                                ),),);
                          },
                          icon: Icon(Icons.delete)),

                    ),
                  );
                }
            );
          },

        ),
        floatingActionButton: FloatingActionButton(
          onPressed:_AddClass,
          child:  Icon(Icons.add),
        ),
      ),
    );
  }
}

