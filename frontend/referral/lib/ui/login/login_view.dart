import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:referral/assets/background.dart';
import 'package:referral/ui/components/already_have_account_check.dart';
import 'package:referral/ui/components/rounded_button.dart';
import 'package:referral/ui/components/rounded_input_field.dart';
import 'package:referral/ui/components/rounded_password_field.dart';
import 'package:referral/ui/registration/registration_view.dart';
import 'package:stacked/stacked.dart';

import '../../model/doctor.dart';
import 'login_viewmodel.dart';


class LoginView extends StatelessWidget {
	static Route route() => MaterialPageRoute(builder: (context) => LoginView());
	@override
	Widget build(BuildContext context) {
		Size size = MediaQuery.of(context).size;
		return ViewModelBuilder<LoginViewModel>.reactive(
				builder: (context, viewmodel, child) {

				  return Scaffold(
						body: Background(
								child: Column(
										mainAxisAlignment: MainAxisAlignment.center,
										children: <Widget>[
										Container(
													height: size.height*0.35,
												child: new Image.asset(
																	'lib/assets/login_centre.png',
																	fit: BoxFit.fill,
												)
										),
											SizedBox(height: size.height * 0.03),
											RoundedInputField(
													hintText: "Your Username",
													onChanged: (value) => viewmodel.username = value,
													icon: Icons.person,
											),
											RoundedPasswordField(
													isObscure: !viewmodel.hidden,
													onChanged: (value) => viewmodel.password = value,
													onPressed: () => viewmodel.hidden = !viewmodel.hidden,
											),
											RoundedButton(
													text: "LOGIN",
													press: () async {
														final Doctor _user = await viewmodel.authenticate();
														await viewmodel.bindToken(_user.id, viewmodel.token);
														if (_user != null){
															print("TRYING TO PRINT USER OBJECT");
														print(_user);
														Navigator.pushNamedAndRemoveUntil(
																context, '/homeview', ModalRoute.withName('/'),
																arguments: _user);
														}

														//if (_user == null)
														//Navigator.pushNamed(context, '/homeview', arguments: _user);
													},
											),
											SizedBox(height: size.height * 0.03),
											AlreadyHaveAnAccountCheck(
													press: () {
														Navigator.push(
																context,
																MaterialPageRoute(
																		builder: (context) {
																			          return RegistrationView();
																		},
																),
														);
													},
											),
											]
													)
													),
													);
				}, viewModelBuilder: () => LoginViewModel(),

													);
	}
}
