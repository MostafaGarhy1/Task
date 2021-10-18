import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
class EditShowSec extends StatefulWidget {
  DocumentSnapshot EditClass;
  EditShowSec({required this.EditClass}) ;

  @override
  _EditShowSecState createState() => _EditShowSecState();
}

class _EditShowSecState extends State<EditShowSec> {
  TextEditingController _Con2 = TextEditingController();

  @override
  void initState() {
    _Con2=TextEditingController(text: (widget.EditClass.data() as Map)['name2']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              onPressed: () {
                widget.EditClass.reference.update({
                  'name2': _Con2.text
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text("Save".tr),
            ) ,
            FlatButton(
              onPressed: () {
                widget.EditClass.reference.delete().whenComplete(() => Navigator.pop(context));
              },
              child: Text("Delete".tr),
            ) ,
          ],
          backgroundColor: Colors.blueGrey,
          title: Text("Edit Name".tr,style: TextStyle(color: Colors.black),),
          leading:FlatButton(
            onPressed: ()=>Navigator.pop(context),
            child: Icon(Icons.chevron_left),
          ) ,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                child: TextField(
                  controller: _Con2,
                  decoration: InputDecoration(
                      labelText: "Enter The Name".tr
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),

          ],
        ),

      ),
    );
  }
}
