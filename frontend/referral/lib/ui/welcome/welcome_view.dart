import 'package:flutter/material.dart';
import 'package:referral/ui/welcome/widgets/body.dart';

class WelcomeView extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => WelcomeView());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
