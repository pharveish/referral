import 'package:flutter/material.dart';
import 'package:referral/ui/components/constants.dart';
import 'package:referral/ui/components/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onPressed;
  final bool isObscure;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.onPressed,
    this.isObscure,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: widget.isObscure,
        onChanged: widget.onChanged,
        cursorColor: Colors.pink,
        decoration: InputDecoration(
          hintText: "Password",
          labelText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.pink,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            color: Colors.pink,
            onPressed:  widget.onPressed,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
