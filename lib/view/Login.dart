import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusat_bantuan/bloc/user_bloc.dart';
import 'package:pusat_bantuan/widget/loginScreen.dart';
import 'package:pusat_bantuan/model/user_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    final UserBloc bloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      key: scaffold,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: AuthScreen(
            child: screen(context, bloc),
            bottomNavigation: navigation(context),
          ),
        ),
      ),
    );
  }

  Widget screen(BuildContext context, UserBloc bloc) {
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
                      value.isEmpty ? 'EMail Tidak Boleh Kosong' : null,
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
                      "LOGIN",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        userModel.login(
                            emailForm.text.trim(), passwordForm.text)
                          ..then((value) {
                            if (value.user != null) {
                              bloc.add(value.user.uid);
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            } else {
                              scaffold.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Akun Tidak Ada atau email dan password salah."),
                                ),
                              );
                            }
                          });
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
          Text('Belum memiliki akun?'),
          RaisedButton.icon(
            textColor: Colors.white,
            icon: Text("REGISTER"),
            label: Icon(Icons.arrow_forward),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onPressed: () => Navigator.pushNamed(context, '/register'),
          ),
        ],
      ),
    );
  }
}
