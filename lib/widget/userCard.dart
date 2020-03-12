import 'package:flutter/material.dart';
import 'package:pusat_bantuan/model/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  UserCard(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.8,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              offset: Offset(3, 3),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: (user.foto == '')
                ? Image.asset(
                    'assets/user.jpg',
                    fit: BoxFit.fitHeight,
                    height: 200,
                  )
                : Image.network(
                    user.foto,
                    fit: BoxFit.fitHeight,
                    height: 200,
                  ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(user.nama,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 5),
                Text(user.email,
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
