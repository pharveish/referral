import 'package:flutter/material.dart';
import 'package:patient/ui/home/confirmed/confirmed_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ConfirmedView extends StatelessWidget {
	static route ({user}) => MaterialPageRoute(builder: (context)=> ConfirmedView(user: user));
	final user;
	ConfirmedView({this.user});
	@override
	Widget build(BuildContext context) {
					return Scaffold(
					  body: Container(
					  		child: Center(child: Text("Confirmed")),
					  ),
					);
	}
}
