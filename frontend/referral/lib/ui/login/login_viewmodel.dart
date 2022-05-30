import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:referral/model/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../app/dependencies.dart';
import '../../services/doctor/doctor_service.dart';

class LoginViewModel extends BaseViewModel implements Initialisable{
	@override
	void initialise() async{
				print("hello");
				print(token);

	}
	

	Doctor doctor;

	
	String token ="";

	DoctorService get _service => dependency();
  bool _hidden = false;
  get hidden => _hidden;
  set hidden(value) {
    _hidden = value;
    notifyListeners();
  }

  String _username;
  get username => _username;
  set username(value) {
    _username = value;
    notifyListeners();
  }

  String _password;
  get password => _password;
  set password(value) {
    _password = value;
    notifyListeners();
  }
	void bindToken(int id, String token) async {
			token = await FirebaseMessaging.instance.getToken();
		 await _service.bindToken(id, token);
		 notifyListeners();
	}

	Future<Doctor> authenticate() async {
		Doctor user = await _service.getUserByLoginAndPassword(_username, _password);
		if(user==null){
			return null;
		} else {
			SharedPreferences preferences = await SharedPreferences.getInstance();
			preferences.setInt('userid',user.id);
			return user;
		}
	}
}
