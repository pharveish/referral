import 'package:referral/app/dependencies.dart';
import 'package:referral/model/doctor.dart';
import 'package:referral/services/doctor/doctor_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel implements Initialisable{
	@override
	void initialise()async{
	SharedPreferences preferences = await SharedPreferences.getInstance();
	int userid = preferences.getInt('userid');
	if(userid!=null){
		doctor= await _service.getDoctorById(userid);
		loginStatus = "logged";
		print(loginStatus);
		notifyListeners();
	} else {
		loginStatus = "notLogged";
		print(loginStatus);
		notifyListeners();
	}
	}
	Doctor doctor;
	String loginStatus = "null";

	DoctorService get _service => dependency();
}
