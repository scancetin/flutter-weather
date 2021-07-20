import 'package:flutter/material.dart';

class CurrentInfosWidget extends StatefulWidget {
  CurrentInfosWidget({Key key}) : super(key: key);

  @override
  _CurrentInfosWidgetState createState() => _CurrentInfosWidgetState();
}

class _CurrentInfosWidgetState extends State<CurrentInfosWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            valueTile("max", "20'"),
            tilePaddingH(),
            valueTile("min", "15'"),
          ],
        ),
        tilePaddingV(70.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            valueTile("wind", "00 m/s"),
            tilePaddingH(),
            valueTile("hum", "100%"),
          ],
        ),
        tilePaddingV(105.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            valueTile("sunrise", "16:19 PM"),
            tilePaddingH(),
            valueTile("sunset", "09:00 AM"),
          ],
        ),
        SizedBox(height: 25),
      ],
    );
  }

  Column valueTile(String info, String rate) {
    return Column(
      children: [
        Text(info),
        Text(rate),
      ],
    );
  }

  Padding tilePaddingV(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 1,
        width: width,
        color: Colors.black,
      ),
    );
  }

  Padding tilePaddingH() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 30,
        width: 1,
        color: Colors.black,
      ),
    );
  }
}
