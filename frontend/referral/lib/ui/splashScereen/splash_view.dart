import 'package:flutter/material.dart';
import 'package:referral/assets/background.dart';
import 'package:referral/ui/splashScereen/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
	static Route route() => MaterialPageRoute(builder: (context) => SplashView());
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=>SplashViewModel(), builder: (context, viewmodel, child){
		Size size = MediaQuery.of(context).size;
	if(viewmodel.loginStatus=="logged"){
	//WidgetsBinding.instance.addPostFrameCallback((_) {	
		Future.delayed(Duration.zero, () {
														Navigator.pushNamedAndRemoveUntil(
																context, '/homeview', ModalRoute.withName('/'),
																arguments: viewmodel.doctor);
														});
														}
	else if(viewmodel.loginStatus == "notLogged"){
		Future.delayed(Duration.zero, () {
														Navigator.pushNamedAndRemoveUntil(
																context, '/welcome', ModalRoute.withName('/') 
																);
														});
														

	}
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
										]
					)
			),
	);
		});
	}
}
