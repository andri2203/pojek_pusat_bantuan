import 'package:flutter/material.dart';

class Bantuan {
  final String pilihan;
  final Color colors;

  Bantuan({this.pilihan = '', this.colors = Colors.blue});

  factory Bantuan.setPilihan(String _pilih) {
    return Bantuan(
      pilihan: _pilih,
      colors: Colors.green,
    );
  }
}

class Unselected extends Bantuan {}
