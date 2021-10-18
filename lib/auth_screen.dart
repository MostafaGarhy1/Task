import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'picked_image.dart';
class auth_screen extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String name,
    bool login,
    BuildContext ctx,
  ) submit;

  @override
  auth_screen(this.submit);

  _auth_screenState createState() => _auth_screenState();
}

class _auth_screenState extends State<auth_screen> {
  @override
  static bool _login = true;
  static var email = '';
  static var name = '';
  static var password = '';

  Widget build(BuildContext context) {
    var emailk = GlobalKey();
    var namek = GlobalKey();
    var passwordk = GlobalKey();
    var formk = GlobalKey<FormState>();
    Function? ver() {
      var c = formk.currentState!.validate();
      if (c) {
        formk.currentState!.save();
        widget.submit(
            email.trim(), password.trim(), name.trim(), _login, context);
      } //FocusScope.of(context).unfocus();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          elevation: 25,
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formk,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_login)picked_image(),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email'.tr,
                      icon: Icon(Icons.alternate_email,color: Theme.of(context).primaryColor,),
                      hintText: 'Enter your Email'.tr,
                    ),
                    onSaved: (v) => email = v!,
                    key: emailk,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v!.isEmpty || v.length < 4 || !v.contains('@'))
                        return 'Please Enter Your Email'.tr;
                    },
                  ),
                  if (!_login)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'User Name'.tr,
                        icon: Icon(Icons.person,color: Theme.of(context).primaryColor,),
                        hintText: 'Enter your Name'.tr,
                      ),
                      onSaved: (v) => name = v!,
                      validator: (v) {
                        if (v!.isEmpty || v.length < 4)
                          return 'Please Enter Your Name'.tr;
                      },
                      key: namek,
                    ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password'.tr,
                      icon: Icon(Icons.visibility_outlined,color: Theme.of(context).primaryColor,),
                      hintText: 'Enter your Password'.tr,
                    ),
                    onSaved: (v) => password = v!,
                    validator: (v) {
                      if (v!.isEmpty || v.length < 6)
                        return 'Please Enter Your Password'.tr;
                    },
                    obscureText: true,
                    key: passwordk,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: ver,
                    child: _login ? Text('LogIn'.tr) : Text('SignUp'.tr),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _login = !_login;
                      });
                    },
                    child: Text(_login ? 'I don\'t have a account'.tr : 'LogIn'.tr),
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
