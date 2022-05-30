import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:patient/app/router.dart';
import 'app/dependencies.dart' as di;

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	di.init();	
	await FlutterDownloader.initialize(
		debug:true
	);
	FlutterDownloader.registerCallback(TestClass.callback);
	runApp(MyApp());
}

class TestClass{
     static void callback(String id, DownloadTaskStatus status, int progress) {}
}

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
				debugShowCheckedModeBanner: false,
				title: 'Referral Patient',
				theme: ThemeData(
						primarySwatch: Colors.blue,
				),
				initialRoute: '/',
				onGenerateRoute: createRoute,
		);
	}
}

