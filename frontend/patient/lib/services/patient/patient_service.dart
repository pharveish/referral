
import 'package:patient/model/patient.dart';

abstract class PatientService {
	Future<Patient> getUserByLoginAndPassword(String username, String password);
}
