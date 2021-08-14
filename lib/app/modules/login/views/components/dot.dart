import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({Key? key,this.color,this.radius}) : super(key: key);
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: this.radius,
      height: this.radius,
      decoration: BoxDecoration(
        color: this.color,
        shape: BoxShape.circle,
      ),
    );
  }
}
