import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusat_bantuan/bloc/bantuanBloc.dart';
import 'package:pusat_bantuan/bloc/user_bloc.dart';
import 'package:pusat_bantuan/view/Login.dart';
import 'package:pusat_bantuan/view/myHomePage.dart';
import './view/Register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => BantuanBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Login(),
        routes: {
          '/register': (context) => Register(),
          '/home': (context) => MyHomePage(),
        },
      ),
    );
  }
}
