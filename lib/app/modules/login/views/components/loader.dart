import 'package:flutter/material.dart';

import 'dot.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      color: Colors.white.withOpacity(0.5),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dot(
              radius: 10,
              color: Colors.blue,
            ),
            Dot(
              radius: 10,
              color: Colors.red,
            ),
            Dot(
              radius: 10,
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
