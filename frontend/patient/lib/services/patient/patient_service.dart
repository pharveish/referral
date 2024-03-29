
import 'package:patient/model/patient.dart';

abstract class PatientService {
	Future<Patient> getUserByLoginAndPassword(String username, String password);
	Future<Patient> getPatientDetails(String nric);
	Future<Patient> bindToken(int id, String token);
}
