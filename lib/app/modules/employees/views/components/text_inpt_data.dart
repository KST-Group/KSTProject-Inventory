import 'package:flutter/material.dart';

class TextInputData extends StatelessWidget {
  const TextInputData({Key? key,this.title,this.onChange,this.label, this.controller}) : super(key: key);

  final String? title;
  final ValueChanged<String>? onChange;
  final String? label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 150,
            child: Text(
              '$label',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
            margin: EdgeInsets.only(right: 20),
          ),
          Container(
            width: 300,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                isDense: true,
                labelText: title??'',
              ),
              onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}


