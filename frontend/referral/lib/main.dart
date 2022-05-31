import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'app/dependencies.dart' as di;
import 'app/router.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel("high importance channel", "high importance notifications", 
		importance: Importance.high);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	  // initialize firebase
  await Firebase.initializeApp();

  // you can just pass the function like this
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
	await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


	di.init();	
	await FlutterDownloader.initialize(
		debug:true
	);
	FlutterDownloader.registerCallback(TestClass.callback);
	runApp(MyApp());
}
	

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  // you need to initialize firebase first
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
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
				title: 'Referral Doctor',
				theme: ThemeData(
						primarySwatch: Colors.pink,
				),
				initialRoute: '/',
				onGenerateRoute: createRoute,
		);
	}
}
