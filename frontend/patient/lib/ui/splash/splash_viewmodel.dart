import 'package:patient/app/dependencies.dart';
import 'package:patient/model/patient.dart';
import 'package:patient/services/patient/patient_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel implements Initialisable{
	@override
	void initialise()async{
	SharedPreferences preferences = await SharedPreferences.getInstance();
	String nric = preferences.getString('nric');
	if(nric!=null){
		patient= await _service.getPatientDetails(nric);
		loginStatus = "logged";
		print(loginStatus);
		notifyListeners();
	} else {
		loginStatus = "notLogged";
		print(loginStatus);
		notifyListeners();
	}
	}
	Patient patient;
	String loginStatus = "null";

	PatientService get _service => dependency();
}
