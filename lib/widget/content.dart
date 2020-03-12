import 'package:flutter/material.dart';
import 'package:pusat_bantuan/view/mapScreen.dart';

List<String> kategori = ['polisi', 'damkar', 'rumkit'];

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  String _kategori = 'polisi';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Pusat Bantuan",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Cari Pusat Bantuan Polisi, Rumah Sakit dan Pemadam Kebakaran Terdekat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                image: 'assets/polri.png',
                color: _kategori == kategori[0] ? Colors.green : Colors.blue,
                padding: 15,
                radius: 60,
                onClick: () {
                  setState(() {
                    _kategori = kategori[0];
                  });
                },
              ),
              SizedBox(width: 15),
              CustomButton(
                icon: Icons.place,
                color: Colors.green,
                padding: 20,
                radius: 100,
                onClick: () {
                  if (_kategori != '') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MapScreen(
                        kategori: _kategori,
                      ),
                    ));
                  }
                },
              ),
              SizedBox(width: 15),
              CustomButton(
                image: 'assets/kemkes.png',
                color: _kategori == kategori[2] ? Colors.green : Colors.blue,
                padding: 15,
                radius: 60,
                onClick: () {
                  setState(() {
                    _kategori = kategori[2];
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Center(
            child: CustomButton(
              image: 'assets/pemadam.png',
              color: _kategori == kategori[1] ? Colors.green : Colors.blue,
              padding: 15,
              radius: 60,
              onClick: () {
                setState(() {
                  _kategori = kategori[1];
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  final double radius;
  final double padding;
  final Color color;
  final String image;

  const CustomButton(
      {Key key,
      this.onClick,
      this.icon,
      this.radius,
      this.color,
      this.padding,
      this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: key,
      color: icon != null ? color : Colors.white,
      padding: EdgeInsets.all(padding),
      splashColor: color,
      child: icon != null
          ? Icon(
              icon,
              size: radius,
              color: Colors.white,
            )
          : Image(
              image: AssetImage(image),
              fit: BoxFit.fitHeight,
              height: radius,
            ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius + padding),
        side: BorderSide(color: color, style: BorderStyle.solid),
      ),
      onPressed: onClick,
    );
  }
}
