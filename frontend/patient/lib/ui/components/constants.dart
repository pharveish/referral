import 'package:flutter/material.dart';

//const kPrimaryColor = Color.fromRGBO(60, 109, 113, 1);
const kPrimaryColor = Color.fromRGBO(82, 86, 232, 1);
const kBackgroundColor = Color.fromRGBO(241, 241, 241, 1);
const kPrimaryLightColor = Color.fromRGBO(216, 216, 216, 1);
const kSecondaryColor = Color.fromRGBO(40, 74, 99, 1);
const kLightPrimaryColor = Color.fromRGBO(65, 127, 133, 1);
const kDarkPrimayColor = Color.fromRGBO(34, 61, 64, 1);
const kDarkerPrimayColor = Color.fromRGBO(29, 47, 48, 1);
//34, 61, 64
//29, 47, 48
//65, 127, 133

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
