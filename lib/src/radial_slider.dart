import 'dart:math';
import 'package:flutter/material.dart';


class RadialSlider extends StatefulWidget {
  double radius;
  double maxAngle;
  Widget background;
  Color color;
  Color backgroundColor;
  Gradient backgroundGradient;
  ValueChanged<double> onChange;
  ValueChanged<double> onChanging;
  double startAngle;

  RadialSlider({
    this.radius,
    this.maxAngle = pi * 2,
    this.background,
    this.color = Colors.orange,
    this.backgroundColor = Colors.purple,
    this.startAngle = -pi/2,
    this.backgroundGradient = const RadialGradient(
      colors: <Color>[Colors.black12, Colors.black26, Colors.black45,],
      stops: <double>[0.6, 0.8, 1.0,],
    ),
    this.onChange,
    this.onChanging,
  });

  @override
  _RadialSliderState createState() => _RadialSliderState();
}

class _RadialSliderState extends State<RadialSlider> {

  double angle = 0.0;

  @override
  void initState() {
    super.initState();
    angle = widget.startAngle;
  }

  _onPointerUp(PointerUpEvent evt) {
    if (widget.onChange != null) {
      widget.onChange(angle - widget.startAngle);
    }
  }

  _onPointerMove(PointerMoveEvent evt, BuildContext context) {
    var dx = evt.delta.dx,
        dy = evt.delta.dy;
    var dAngle = pi / 2 + angle - atan2(dy, dx);

    // project dx dy onto circle
    var dPos = cos(dAngle) * sqrt(pow(dx, 2) + pow(dy, 2));
    var r = _CicleLayoutDelegate.getRadius(context.size, widget.radius);
    var newAngle = min(angle + dPos / r, widget.maxAngle + widget.startAngle);
    newAngle = max(widget.startAngle, newAngle);
    setState(() {
      angle = newAngle;
    });

    if (widget.onChanging != null) {
      widget.onChanging(newAngle - widget.startAngle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: widget.background != null ? widget.background : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.backgroundColor,
              gradient: widget.backgroundGradient,
            ),
            width: widget.radius != null ? widget.radius * 2 + 50.0 : null,
            height: widget.radius != null ? widget.radius * 2 + 50.0 : null,
          ),
        ),
        Listener(
          onPointerMove: (evt) {_onPointerMove(evt, context);},
          onPointerUp: _onPointerUp,
          child: CustomSingleChildLayout(
            delegate: _CicleLayoutDelegate(
              angle: angle,
              radius: widget.radius,
            ),
            child: RaisedButton(
              onPressed: () {},
              shape: CircleBorder(),
              color: widget.color,
            ),
          ),
        ),
      ],
    );
  }
}

class _CicleLayoutDelegate extends SingleChildLayoutDelegate {
  static getRadius(Size size, double radius) {
    if (radius == null && size.width != double.infinity && size.height != double.infinity) {
      return min(size.width, size.height) / 2;
    }
    return radius;
  }
  double radius;
  double angle;

  _CicleLayoutDelegate({this.radius, this.angle});

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    var r = getRadius(size, radius);
    var center = Offset(
      (size.width - childSize.width) / 2,
      (size.height - childSize.height) / 2,
    );

    return center.translate(r * cos(angle), r * sin(angle));
  }

  @override
  bool shouldRelayout(_CicleLayoutDelegate oldDelegate) {
    return oldDelegate.angle != angle
    || oldDelegate.radius != radius;
  }
}