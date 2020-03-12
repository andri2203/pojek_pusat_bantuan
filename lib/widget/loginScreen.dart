import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final Widget child;
  final Widget bottomNavigation;

  const AuthScreen({Key key, this.bottomNavigation, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.5, 0.5],
          colors: [
            Colors.blue,
            Colors.white,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.only(top: 15),
            child: Text(
              'PUSAT\r\nBANTUAN',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
          Center(child: child),
          bottomNavigation,
        ],
      ),
    );
  }
}
