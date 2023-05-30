import 'package:flutter/material.dart';

enum DefaultIcon { calendar, pendentes, procurar }

Image defaultIcon(DefaultIcon defaultIcon) {
  String diretorio = "";

  switch (defaultIcon) {
    case DefaultIcon.calendar:
      diretorio = "assets/images/Calendar.png";
      break;
    case DefaultIcon.pendentes:
      diretorio = "assets/images/Messages.png";
      break;
    case DefaultIcon.procurar:
      diretorio = "assets/images/Search.png";
      break;
    default:
      diretorio = "";
  }

  return Image.asset(diretorio, height: 45);
}
