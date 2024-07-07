import 'dart:ui';

import 'package:flutter/material.dart';

class kInputBoxes extends StatelessWidget {
  String? title;
  String? hintText;
  bool obsecure;

  kInputBoxes(
      {super.key,
      required this.title,
      required this.hintText,
      this.obsecure = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(title!),
        ),
        TextField(
          obscureText: obsecure,
          decoration:
              InputDecoration(hintText: hintText, border: OutlineInputBorder()),
        ),
      ],
    );
  }
}

class kLoginButton extends StatelessWidget {
  String? title;
  VoidCallback? ontap;
  kLoginButton(
      {super.key,
      required this.title,
      this.boxcolor,
      this.textcolor,
      this.ontap,
      this.fontSize});
  Color? textcolor;
  Color? boxcolor;
  double? fontSize = 19;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade300),
          color: boxcolor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title!,
            style: TextStyle(
              color: textcolor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
