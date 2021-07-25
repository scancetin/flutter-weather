import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'"),
        ),
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'"),
        ),
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'"),
        ),
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'"),
        ),
        ListTile(
          leading: Text("Monday"),
          title: Align(alignment: Alignment.centerRight, child: Icon(Icons.wb_sunny)),
          trailing: Text("23' / 18'"),
        ),
      ],
    );
  }
}