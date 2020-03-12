import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String nama;
  final String email;
  final String foto;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  UserModel({this.id, this.nama, this.email, this.foto});

  factory UserModel.creatuser(DocumentSnapshot document) {
    return UserModel(
      id: document.documentID,
      nama: document['nama'],
      email: document['email'],
      foto: document['foto'],
    );
  }

  static Future<UserModel> getUserFromAuth(String uid) async {
    var data = await Firestore.instance.collection('user').document(uid).get();

    return UserModel.creatuser(data);
  }

  Future register(String nama, email, password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((AuthResult value) async {
        await firestore.collection('user').document(value.user.uid).setData({
          'nama': nama,
          'email': email,
          'password': password,
          'foto': '',
        });
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<AuthResult> login(String email, password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}

class UninitializedUser extends UserModel {}
