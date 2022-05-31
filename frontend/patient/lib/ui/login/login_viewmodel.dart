
import 'package:patient/app/dependencies.dart';
import 'package:patient/model/patient.dart';
import 'package:patient/services/patient/patient_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel{
	@override
	PatientService get _service => dependency();
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

	Future<Patient> authenticate() async {
		Patient user = await _service.getUserByLoginAndPassword(_username, _password);
		if(user==null){
			return null;
		} else {
			SharedPreferences preferences = await SharedPreferences.getInstance();
			preferences.setString('nric',user.nric);
			return user;
		}
	}
}
