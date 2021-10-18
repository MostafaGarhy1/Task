import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
class EditShowPrep extends StatefulWidget {
  DocumentSnapshot EditClass;
  EditShowPrep({required this.EditClass}) ;


  @override
  _EditShowPrepState createState() => _EditShowPrepState();
}

class _EditShowPrepState extends State<EditShowPrep> {
  TextEditingController _Con1 = TextEditingController();

  @override
  void initState() {
    _Con1=TextEditingController(text: (widget.EditClass.data() as Map)['name1']);
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
                  'name1': _Con1.text
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
                  controller: _Con1,
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
