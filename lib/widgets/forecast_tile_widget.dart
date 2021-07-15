import 'package:flutter/material.dart';

class ForecastTileWidget extends StatelessWidget {
  final String day;
  final String maxTemp;
  final String minTemp;
  final Icon icon;
  final String scale;
  const ForecastTileWidget({Key key, this.day, this.icon, this.maxTemp, this.minTemp, this.scale}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'C"),
        ),
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'C"),
        ),
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'C"),
        ),
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'C"),
        ),
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'C"),
        ),
      ],
    );
  }
}
