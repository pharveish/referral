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
	Future<Patient> getPatientDetails(String nric) async{
		final Map<String, dynamic> patientDetails = await rest.get('api/Patient/nric/$nric');
		if(patientDetails==null){
			return null;
		} else return Patient.fromJson(patientDetails);
	}

	Future<Patient> bindToken(int id, String token) async {
		final Map<String, dynamic> doctorJson = await rest.put('api/patient/bindToken/$id', data:{
			"fbToken": token,
		});
		final Patient _patient = Patient.fromJson(doctorJson);
		return _patient;
	}
}
