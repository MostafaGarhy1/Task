import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'edit_show_sec.dart';
class ShowSec extends StatefulWidget {
  DocumentSnapshot ShowClass;

  ShowSec({required this.ShowClass}) ;


  @override
  _ShowSecState createState() => _ShowSecState();
}

class _ShowSecState extends State<ShowSec> {

  TextEditingController _name2 = TextEditingController();

  _AddName(){
    showDialog(
        context: context,
        builder:(BuildContext context)=>AlertDialog(
          title: Text("Add Name".tr),
          content: Column(
            children: [
              Container(
                child: TextField(
                  controller: _name2,
                  decoration: InputDecoration(
                      labelText: "Enter The Name".tr
                  ),
                ),
              ),
              FlatButton(
                onPressed: (){
                  FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('Classes2').doc((widget.ShowClass.data() as Map)['title2']).collection('student2').add({
                    'name2': _name2.text,
                    'val2': _name2.hasListeners,
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
          title: Text((widget.ShowClass.data() as Map)['title2'],style: TextStyle(color: Colors.black),),
          leading:FlatButton(
            onPressed: ()=>Navigator.pop(context),
            child: Icon(Icons.chevron_left),
          ) ,
          actions: [
            IconButton(
                onPressed:(){
                  widget.ShowClass.reference.update({
                    'time2':DateTime.now().day,
                  });
                } ,
                icon: Icon(Icons.save)),
            FlatButton(
              onPressed:(){
                widget.ShowClass.reference.update({
                  'time2':DateTime.now().day-1,
                });
              } ,
              child: Text("Edit Absence".tr),),


          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Classes2').doc((widget.ShowClass.data() as Map)['title2']).collection('student2').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.hasData?snapshot.data!.docs.length:0,
                itemBuilder: (ctx,index){
                  return  Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index].data()['name2']),
                      leading: IconButton(
                          onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>EditShowSec(EditClass:snapshot.data!.docs[index]))),
                          icon: Icon(Icons.edit)),
                      trailing: (widget.ShowClass.data() as Map)['time2']== DateTime.now().day?( snapshot.data!.docs[index].data()['val2']==true?
                      Container(
                        child: Text(
                          "Exist".tr,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ):Container(
                        child: Text(
                          "Absent".tr,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      )):Checkbox(
                        value: snapshot.data!.docs[index].data()['val2'],
                        onChanged: (bool? value) {
                          if(value!=null){
                            setState(() {
                              snapshot.data!.docs[index].reference.update({
                                'val2':value
                              });

                            });
                          }
                        },

                      ),
                    ),
                  );
                }
            );
          },

        ),
        floatingActionButton: FloatingActionButton(
          onPressed:_AddName,
          child:  Icon(Icons.add),
        ),
      ),
    );
  }
}
