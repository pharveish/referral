import 'package:patient/app/dependencies.dart';
import 'package:patient/model/patient.dart';
import 'package:patient/services/patient/patient_service.dart';
import 'package:patient/services/rest.dart';

class PatientServiceRest implements PatientService{
	RestService get rest => dependency();
	Future<Patient> getUserByLoginAndPassword(String username, String password)
			async {
				final Map<String, dynamic> user = 
						await rest.post('api/patient/authenticate', data:{
							"username": username,
							"password": password,
						});
				if(user==null){
					return null;
				} else {
					print('token: '+user['token']);
					var loggedInUser = Patient.fromJson(user);
					return loggedInUser;
				}
			}
}
