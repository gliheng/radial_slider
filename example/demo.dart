import 'package:flutter/material.dart';
import 'package:radial_slider/radial_slider.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red,
        brightness: Brightness.light,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Demo')
          ),
          body: AppBody(),
      )
    );
  }
}

class AppBody extends StatefulWidget {
  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  double angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Center(child: Text('Angle: $angle'))
        ),
        Expanded(
          flex: 3,
          child: RadialSlider(
            color: Colors.yellow,
            backgroundColor: Colors.blue,
            backgroundGradient: null,
            radius: 120.0,
            maxAngle: pi * 2,
            onChange: (a) {
              setState(() {
                angle = a;
              });
            },
            onChanging: (a) {
              setState(() {
                angle = a;
              });
            },
          ),
        )
      ],
    );
  }
}
