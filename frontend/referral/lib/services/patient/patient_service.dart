import 'package:referral/model/patient.dart';

abstract class PatientService {
	Future<Patient> getPatientDetails(String nric);
}
