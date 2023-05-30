import 'package:flutter/material.dart';

Text defaultText({String text = "", TextStyle? textStyle}) {
  return Text(
    text,
    style: const TextStyle(fontFamily: 'Rubik')
        .merge(textStyle ?? const TextStyle()),
    
  );
}
