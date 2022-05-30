import 'package:referral/app/dependencies.dart';
import 'package:referral/model/doctor.dart';
import 'package:referral/model/referral.dart';
import 'package:referral/services/doctor/doctor_service.dart';
import 'package:referral/services/referral/referral_service.dart';
import 'package:stacked/stacked.dart';


class SpecialtyListViewModel extends BaseViewModel{
	List specialtyList = ['Internal Medicine', 'Orthopaedics', 'Paediatrics', 'Obstetrics', 'ENT', 'Opthalmology', 'Neurosurgery', 'Radiology', 'Anaesthesiology', 'Medical Officer'];

	DoctorService get _service => dependency();
	ReferralService get _serviceRef => dependency();

	List<Doctor> doctorList = [];
	List<Doctor> filteredList=[];

 	Referral referral;

	void reassign(id, doctorToId)async{
		referral = await _serviceRef.reassign(id, doctorToId);
		print("reassigning");
		notifyListeners();
	}

	void filterSpecialty(specialty)async{
		doctorList = await _service.getDoctorsBySpecialty(specialty);
		print("filtering");
		notifyListeners();
	}

}
