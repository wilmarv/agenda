import 'package:flutter/material.dart';

Widget defaultTexto(String text, TextStyle? textStyle) {
  return Text(
    text,
    style: const TextStyle(fontFamily: 'Rubik').merge(textStyle),
  );
}
