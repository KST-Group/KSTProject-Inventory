import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatelessWidget {
  TextInput({
    Key? key,
    required this.hint,
    required this.secure,
    required this.controller,
    this.validator,this.onSaved
  }) : super(key: key);
  final String hint;
  final bool secure;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  FormFieldSetter<String>? onSaved;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,

        obscureText: secure,
        style: GoogleFonts.notoSans(fontSize: 16),
        decoration: InputDecoration(

          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.notoSans(fontSize: 16),
          focusColor: Colors.blue,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.blue),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
