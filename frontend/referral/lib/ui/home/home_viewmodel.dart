import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:referral/app/dependencies.dart';
import 'package:referral/main.dart';
import 'package:referral/services/doctor/doctor_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel implements Initialisable{
	@override
	void initialise(){
var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android?.smallIcon,
              ),
            ));
      }
    });
	}
	DoctorService get _service => dependency();
	void removeToken(int id) async {
		await FirebaseMessaging.instance.deleteToken();
		 await _service.bindToken(id, "");
		 notifyListeners();
	}
}
