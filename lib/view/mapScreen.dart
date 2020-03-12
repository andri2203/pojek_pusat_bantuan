import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pusat_bantuan/services/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final String kategori;

  const MapScreen({Key key, this.kategori}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location posisi = new Location(latitude: 5.549434, longitude: 95.3197276);
  String get kategori => widget.kategori;
  CollectionReference firestore = Firestore.instance.collection('lokasi');
  List<Map<String, dynamic>> nearby = new List<Map<String, dynamic>>();
  Completer<GoogleMapController> _controller = Completer();
  String alamat = '';

  @override
  void initState() {
    super.initState();
    this.getCurrentLocation();
    this.getNearBy();
    this.getAddress();
  }

  Future<void> getCurrentLocation() async {
    Location location = await Location.currentPosition();
    setState(() {
      posisi = location;
    });
  }

  Future<void> getNearBy() async {
    firestore.where("kategori", isEqualTo: widget.kategori)
      ..getDocuments().then((event) {
        event.documents.forEach((element) async {
          double endLatitude = element.data['latitude'];
          double endLongitude = element.data['longitude'];
          double near = await Location.nearby(endLatitude, endLongitude);

          setState(() {
            nearby.add({'nearby': near, 'data': element.data});
          });
        });
      });
  }

  Future<void> getAddress() async {
    var placeMark = await Location.address();

    setState(() {
      alamat =
          "Lokasi Anda:\r\nKampung ${placeMark.subLocality}\r\n${placeMark.locality}\r\n${placeMark.subAdministrativeArea}";
    });
  }

  List<Map<String, dynamic>> data() {
    nearby.sort((a, b) => (a['nearby']).compareTo(b['nearby']));
    return nearby;
  }

  @override
  Widget build(BuildContext context) {
    if (nearby.isNotEmpty) {
      LokasiPeta lokasi = LokasiPeta.getDataFromList(data()[0]);
      int jarak = (data()[0]['nearby']).round();

      return Scaffold(
        appBar: AppBar(
          title: Text(lokasi.nama),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: (controller) {
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(lokasi.latitude, lokasi.longitude),
                      zoom: 17,
                    ),
                  ));
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(lokasi.latitude, lokasi.longitude),
                  zoom: 17,
                ),
                mapType: MapType.normal,
                markers: {
                  Marker(
                    markerId: MarkerId("${lokasi.kategori}"),
                    position: LatLng(lokasi.latitude, lokasi.longitude),
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                },
                mapToolbarEnabled: true,
                zoomGesturesEnabled: false,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        alamat,
                        softWrap: true,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Jarak ${jarak / 1000} Km',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.amber,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      var url = 'tel:${lokasi.noHp}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

class LokasiPeta {
  final String nama;
  final double latitude;
  final double longitude;
  final String noHp;
  final String kategori;

  LokasiPeta({
    this.kategori,
    this.nama,
    this.latitude,
    this.longitude,
    this.noHp,
  });

  factory LokasiPeta.getDataFromList(Map<String, dynamic> data) {
    return LokasiPeta(
      nama: data['data']['nama'],
      latitude: data['data']['latitude'],
      longitude: data['data']['longitude'],
      noHp: data['data']['tlp'],
      kategori: data['data']['lategori'],
    );
  }
}
