import 'package:referral/app/dependencies.dart';
import 'package:referral/model/doctor.dart';
import 'package:referral/model/referral.dart';
import 'package:referral/services/doctor/doctor_service.dart';
import 'package:referral/services/referral/referral_service.dart';
import 'package:stacked/stacked.dart';

class DoctorListViewModel extends BaseViewModel implements Initialisable {
	@override
	void initialise(){
		getList();
	}

	//DoctorListViewModel(){
		//getList();
		//print(doctorList);
	//}

	DoctorService get _service => dependency();
	ReferralService get _serviceRef => dependency();
	
	Future<List<Doctor>> getDoctorList() async{
		List doctors = await _service.getDoctorList();
		return doctors;
	}

	List<Doctor> doctorList=[];
	List<Doctor> filteredList=[];

	Referral referral;

	List specialtyList = ['Internal Medicine', 'Orthopaedics', 'Paediatrics', 'Obstetrics', 'ENT', 'Opthalmology', 'Neurosurgery', 'Radiology', 'Anaesthesiology', 'Medical Officer'];

	void filterSpecialty(specialty)async{
		filteredList = await _service.getDoctorsBySpecialty(specialty);
		print("filtering");
		notifyListeners();
	}

	void reassign(id, doctorToId)async{
		referral = await _serviceRef.reassign(id, doctorToId);
		print("reassigning");
		notifyListeners();
	}

	void getList() async{
		//Future<List<Doctor>> _doctors = getDoctorList();
		//List<Doctor> doctors = await _doctors;
		//_doctorList=doctors;
		doctorList = await _service.getDoctorList();
		//print("assigned doctos");
		notifyListeners();
		//print(doctorList);
	}

}
