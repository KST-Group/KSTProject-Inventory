import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kst_inventory/utils/dot.dart';

class Dialogs {
  final BuildContext context;
  final String message;

  Dialogs({required this.context, required this.message});

  void optionDialog({required VoidCallback onPress}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onPress();
                },
                child: Text('OK')),
          ],
        );
      },
    );
  }

  void progressDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  void showToast(){
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM_LEFT,
      webPosition: 'center',
      webBgColor: 'none',
      textColor: Colors.green,
    );
  }

  void errorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Access denied',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage('assets/images/sad_face.png'),
                width: 40,
              ),
              SizedBox(
                height: 5,
              ),
              Text(message),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }

  void dispose(){
    Navigator.of(context).pop();
  }
}
