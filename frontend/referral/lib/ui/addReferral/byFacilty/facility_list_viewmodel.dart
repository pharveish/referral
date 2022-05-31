import 'package:referral/app/dependencies.dart';
import 'package:referral/model/doctor.dart';
import 'package:referral/model/referral.dart';
import 'package:referral/services/delegate/delegate_service.dart';
import 'package:referral/services/doctor/doctor_service.dart';
import 'package:referral/services/referral/referral_service.dart';
import 'package:stacked/stacked.dart';

class FacilityListViewModel extends BaseViewModel{

	List specialtyList = ['Internal Medicine', 'Orthopaedics', 'Paediatrics', 'Obstetrics', 'ENT', 'Opthalmology', 'Neurosurgery', 'Radiology', 'Anaesthesiology', 'Medical Officer'];
	List hospitalList = ['Kempas Medical Centre', 'Maria Hospital', 'Hospital Columbia Asia Tebrau', 'Hospital Columbia Asia Nusajaya', 'Hospital Pakar Puteri', 'Hospital Pakar KPJ Johor', 'Hospital Penawar', 'Hospital Gleneagles'];

	DoctorService get _service => dependency();
	ReferralService get _serviceRef => dependency();
	DelegateService get _serviceDel => dependency();

	List<Doctor> doctorList = [];
	List<Doctor> filteredList=[];

	void filterSpecialty(specialty)async{
		doctorList = await _service.getDoctorsBySpecialty(specialty);
		notifyListeners();
	}

	Referral referral;

	void addToDelegate(delegateFromId, delegateToId)async{
		await _serviceDel.addToDelegates(delegateFromId, delegateToId);
		print("delegating");
		notifyListeners();
	}

	void reassign(id, doctorToId)async{
		referral = await _serviceRef.reassign(id, doctorToId);
		print("reassigning");
		notifyListeners();
	}

	void filterHospital(hospital)async{
		doctorList = await _service.getDoctorsByHospital(hospital);
		print("filtering");
		notifyListeners();
	}
}
