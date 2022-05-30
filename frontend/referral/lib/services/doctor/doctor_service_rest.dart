import 'package:referral/app/dependencies.dart';
import 'package:referral/model/doctor.dart';
import 'package:referral/services/rest.dart';
import 'doctor_service.dart';

class DoctorServiceRest implements DoctorService{
	RestService get rest => dependency();	

	Future<Doctor> getUserByLoginAndPassword(String username, String password)
			async {
				final Map<String, dynamic> user = 
						await rest.post('api/doctor/authenticate', data:{
							"username": username,
							"password": password,
						});
				if(user==null){
					return null;
				} else {
					print ('token: '+user['token']);
					var loggedInUser = Doctor.fromJson(user);
					return loggedInUser;
				}
			}

	Future<Doctor> bindToken(int id, String token) async {
		final Map<String, dynamic> doctorJson = await rest.put('api/doctor/bindToken/$id', data:{
			"fbToken": token,
		});
		final Doctor _doctor = Doctor.fromJson(doctorJson);
		return _doctor;
	}

	Future<List<Doctor>> getDoctorList() async{
		final List listJson = await rest.get('api/doctor');
		return listJson.map((json)=>Doctor.fromJson(json)).toList();
	}

	Future<List<Doctor>> getDoctorsBySpecialty(String specialty) async{
		final List listJson = await rest.get('api/doctor/specialty/$specialty');
		return listJson.map((json)=>Doctor.fromJson(json)).toList();
	}

	Future<List<Doctor>> getDoctorsByHospital(String hospital) async{
		final List listJson = await rest.get('api/doctor/hospital/$hospital');
		return listJson.map((json)=>Doctor.fromJson(json)).toList();
	}

	Future<Doctor> getDoctor(int id) async {
		final Map<String, dynamic> doctor = await rest.get('api/doctor/$id');
		if(doctor==null){
			return null;
		} else return Doctor.fromJson(doctor);
	}

	Future<Doctor> getDoctorById(int id) async {
		final Map<String, dynamic> doctor = await rest.get('api/doctor/$id');
		if(doctor==null){
			return null;
		} else return Doctor.fromJson(doctor);
	}
	Future<Doctor> register(String username, String password, String email, String name, String credentials, String specialty, String officePhone, String mobilePhone, String fax, String hospital)async{
		final Map<String, dynamic> doctorJson = await rest.post('api/Doctor', data: {
			"username":username,
			"password":password,
			"email":email,
			"name":name,
			"credentials":credentials,
			"specialty":specialty,
			"officePhone":officePhone,
			"mobilePhone":mobilePhone,
			"fax":fax,
			"hospital":hospital,
		});
		final Doctor _doctor = Doctor.fromJson(doctorJson);
		return _doctor;
	}

}
