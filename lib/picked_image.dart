
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';

class picked_image extends StatefulWidget {
  @override
  _picked_imageState createState() => _picked_imageState();
}

class _picked_imageState extends State<picked_image> {
  File? pickedImage;
  ImagePicker picker=ImagePicker();
  void pick(ImageSource src)async{
    PickedFile? pickfile = await picker.getImage(source: src);
     if(pickfile!=null){
       setState(() {
         pickedImage=File(pickfile.path);
       });
     }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blueGrey,
          backgroundImage:pickedImage!= null?FileImage(pickedImage!):null ,
        ),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(onPressed:()=>pick(ImageSource.camera), icon:Icon(Icons.photo_camera_outlined,color: Theme.of(context).primaryColor,), label:Text('Add Image\nFrom Camera'.tr) ),
            FlatButton.icon(onPressed: ()=>pick(ImageSource.gallery), icon:Icon(Icons.image_outlined,color: Theme.of(context).primaryColor,), label:Text('Add Image\nFrom Gallery'.tr)),
          ],
        ),
      ],
    );
  }
}

