import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'show_prim.dart';
class PrimaryStage extends StatefulWidget {
  PrimaryStage({Key? key}) : super(key: key);

  @override
  State<PrimaryStage> createState() => _PrimaryStageState();
}

class _PrimaryStageState extends State<PrimaryStage> {
  TextEditingController _Con = TextEditingController();

  _AddClass(){
    showDialog(
        context: context,
        builder:(BuildContext context)=>AlertDialog(
          title: Text("Add Class".tr),
          content: Column(
            children: [
              Container(
                child: TextField(
                  controller: _Con,
                  decoration: InputDecoration(
                      labelText: "Enter The Class Name".tr
                  ),
                ),
              ),
              FlatButton(
                onPressed: (){
                  FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('Classes').doc(_Con.text).set({
                    'title': _Con.text,
                    'time':DateTime.now().day-1,
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
          title: Text("Primary Stage".tr,style: TextStyle(color: Colors.black),),
          leading:FlatButton(
            onPressed: ()=>Navigator.pop(context),
            child: Icon(Icons.chevron_left),
          ) ,

        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('Classes').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.hasData?snapshot.data!.docs.length:0,
                itemBuilder: (ctx,index){
                  return  Card(
                    child: ListTile(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowPrim(ShowClass: snapshot.data!.docs[index]))),
                      title: Text(snapshot.data!.docs[index].data()['title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder:(BuildContext context)=>AlertDialog(
                                title: Text("Are You Sure To Delete The Class?".tr,style: TextStyle(fontWeight: FontWeight.bold)),
                                content: Row(
                                  children: [
                                    FlatButton(
                                        onPressed: (){
                                          snapshot.data!.docs[index].reference.delete().whenComplete(() => Navigator.pop(context));                                       },
                                        child: Text("Ok".tr,style: TextStyle(fontWeight: FontWeight.bold),)),
                                    SizedBox(width: 10,),
                                    FlatButton(
                                        onPressed: ()=>Navigator.pop(context),
                                        child: Text("Close".tr,style: TextStyle(fontWeight: FontWeight.bold))),
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
