import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusat_bantuan/bloc/bantuanBloc.dart';
import 'package:pusat_bantuan/bloc/user_bloc.dart';
import 'package:pusat_bantuan/model/user_model.dart';
import 'package:pusat_bantuan/widget/content.dart';
import 'package:pusat_bantuan/widget/userCard.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: BlocBuilder<UserBloc, UserModel>(
                builder: (context, user) =>
                    (user is UninitializedUser) ? Container() : UserCard(user),
              ),
            ),
            Expanded(
              child: BlocProvider(
                create: (context) => BantuanBloc(),
                child: Content(),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
