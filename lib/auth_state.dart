import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'auth_screen.dart';

class auth_state extends StatefulWidget {
  @override
  _auth_stateState createState() => _auth_stateState();
}

class _auth_stateState extends State<auth_state> {
  @override
  final auth = FirebaseAuth.instance;
  var message;
  var key = GlobalKey();

  void submit(email, password, name, login, BuildContext ctx) async {
    UserCredential auth_res;

    try {
       if (login) {
        auth_res = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        auth_res = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('user')
            .doc(auth_res.user!.uid)
            .set({
          'email':email,
          'username': name,
          'password': password,
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password is too  weak'.tr;
      } else if (e.code == 'email-already-in-use') {
        message = 'The account is already exist'.tr;
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email'.tr;
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user'.tr;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: auth_screen(submit),
    );
  }
}
