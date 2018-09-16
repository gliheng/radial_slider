import 'dart:math';
import 'package:flutter/material.dart';
import 'package:radial_slider/radial_slider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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

const double START_ANGLE = - pi / 2;

class AppBody extends StatefulWidget {
  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  double angle = START_ANGLE;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60.0,
          child: Center(child: Text('Angle: ${angle.toStringAsFixed(2)}'))
        ),
        Expanded(
          flex: 1,
          child: RadialSlider(
            color: Colors.yellow,
            backgroundColor: Colors.blue,
            backgroundGradient: null,
            radius: 120.0,
            initialAngle: angle,
            maxAngle: pi * 2 - START_ANGLE,
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
        ),
        SizedBox(
          height: 30.0,
        )
      ],
    );
  }
}
