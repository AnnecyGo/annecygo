import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {@required this.text,
      @required this.onPressed,
      this.fontSize,
      this.icon});
  final String text;
  final int fontSize;
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 10, 20, 10)),
          minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 20.0)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23.0),
            side: BorderSide(color: Colors.white),
          ))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isIcon()
              ? new Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    icon,
                    size: fontSize.toDouble(),
                    color: Colors.black,
                  ))
              : new Text(""),
          new Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.black,
                fontSize: _fontSize(fontSize),
                fontStyle: FontStyle.normal),
          )
        ],
      ),
      onPressed: onPressed,
    );
  }

  _isIcon() {
    if (icon != null) {
      return true;
    } else {
      return false;
    }
  }

  static double _fontSize(fs) {
    if (fs != null) {
      return fs.toDouble();
    } else {
      return 40;
    }
  }
}
