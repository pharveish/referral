
import 'package:referral/app/dependencies.dart';
import 'package:referral/model/patient.dart';
import 'package:referral/services/patient/patient_service.dart';
import 'package:referral/services/rest.dart';

class PatientServiceRest implements PatientService{
	RestService get rest => dependency();

	Future<Patient> getPatientDetails(String nric) async{
		final Map<String, dynamic> patientDetails = await rest.get('api/Patient/nric/$nric');
		if(patientDetails==null){
			return null;
		} else return Patient.fromJson(patientDetails);
	}

}
