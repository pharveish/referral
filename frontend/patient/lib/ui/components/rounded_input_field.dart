import 'package:flutter/material.dart';
import 'package:patient/ui/components/constants.dart';
import 'package:patient/ui/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final bool extraIcon;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.extraIcon = false,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          labelText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

//class RoundedInputField2 extends StatelessWidget {
//  final bool extraIcon;
//  final String hintText;
//  final FaIcon icon2;
//  final ValueChanged<String> onChanged;
//  const RoundedInputField2({
//    Key? key,
//    this.extraIcon = false,
//    required this.hintText,
//    required this.icon2,
//    required this.onChanged,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return TextFieldContainer(
//      child: TextFormField(
//        onChanged: onChanged,
//        cursorColor: kPrimaryColor,
//        decoration: InputDecoration(
//          icon: icon2,
//          hintText: hintText,
//          labelText: hintText,
//          border: InputBorder.none,
//        ),
//      ),
//    );
//  }
//}
