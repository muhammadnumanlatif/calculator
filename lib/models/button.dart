import 'package:flutter/material.dart';

class Button {
  final String? value;
  final Color? bgColor;
  final Color? fgColor;

  Button(this.value, this.bgColor, this.fgColor);

}

Color grey = Colors.teal.shade400;
Color grey800 = Colors.teal.shade800;
Color black = Colors.teal.shade100;
Color orange = Colors.teal;
Color white = Colors.white;


List<Button> buttons =[
  Button('C', grey, black),
  Button('+/-', grey, black),
  Button('%', grey, black),
  Button('/', orange, white),
  Button('7', grey800, white),
  Button('8', grey800, white),
  Button('9', grey800, white),
  Button('*', orange, white),
  Button('4', grey800, white),
  Button('5', grey800, white),
  Button('6', grey800, white),
  Button('-', orange, white),
  Button('1', grey800, white),
  Button('2', grey800, white),
  Button('3', grey800, white),
  Button('+', orange, white),
  Button('0', grey800, white),
  Button('.', grey800, white),
  Button('=', orange, white),

];