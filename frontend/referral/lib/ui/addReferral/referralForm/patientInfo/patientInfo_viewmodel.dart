import 'package:referral/app/dependencies.dart';
import 'package:referral/model/patient.dart';
import 'package:referral/services/patient/patient_service.dart';
import 'package:stacked/stacked.dart';

class PatientInfoViewModel extends BaseViewModel{
	PatientInfoViewModel();
	PatientService get _service => dependency();
	String nric="";
	Patient patient= new Patient(id: 0, nric: "", email: "", gender: "", homeNo: "", address: "", mobileNo: "", patientName: "");

	void getPatientDetails(nric) async {
		patient = await _service.getPatientDetails(nric);
		notifyListeners();

	}

	
}
