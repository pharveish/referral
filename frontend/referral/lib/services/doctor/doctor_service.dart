import '../../model/doctor.dart';

abstract class DoctorService {
	Future<Doctor> getUserByLoginAndPassword(String username, String password);
	Future<List<Doctor>> getDoctorList();
	Future<List<Doctor>> getDoctorsBySpecialty(String specialty);
	Future<List<Doctor>> getDoctorsByHospital(String hospital);
	Future<Doctor> bindToken(int id, String token);
	Future<Doctor> getDoctorById(int id);
	Future<Doctor> register(String username, String password, String email, String name, String credentials, String specialty, String officePhone, String mobilePhone, String fax, String hospital);
}
