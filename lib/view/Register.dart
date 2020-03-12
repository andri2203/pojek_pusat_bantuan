import 'package:flutter/material.dart';
import 'package:pusat_bantuan/model/user_model.dart';
import 'package:pusat_bantuan/widget/loginScreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController namaForm = new TextEditingController();
  final TextEditingController emailForm = new TextEditingController();
  final TextEditingController passwordForm = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffold = GlobalKey<ScaffoldState>();
  UserModel userModel;

  @override
  void initState() {
    setState(() {
      userModel = UserModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: AuthScreen(
            child: screen(context),
            bottomNavigation: navigation(context),
          ),
        ),
      ),
    );
  }

  Widget screen(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.topCenter,
      child: Card(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'Nama Tidak Boleh Kosong' : null,
                  controller: namaForm,
                  scrollPhysics: ClampingScrollPhysics(),
                  decoration: InputDecoration(hintText: 'Nama'),
                ),
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'Email Tidak Boleh Kosong' : null,
                  controller: emailForm,
                  keyboardType: TextInputType.emailAddress,
                  scrollPhysics: ClampingScrollPhysics(),
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'Password Tidak Boleh Kosong' : null,
                  controller: passwordForm,
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        userModel
                          ..register(
                            namaForm.text,
                            emailForm.text.trim(),
                            passwordForm.text,
                          ).whenComplete(
                            () => Navigator.of(context).pop(),
                          );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navigation(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Anda sudah memiliki akun?'),
          RaisedButton.icon(
            textColor: Colors.white,
            icon: Text("LOGIN"),
            label: Icon(Icons.arrow_forward),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
