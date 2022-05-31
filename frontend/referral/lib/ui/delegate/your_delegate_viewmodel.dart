import 'package:referral/app/dependencies.dart';
import 'package:referral/model/delegate.dart';
import 'package:referral/model/doctor.dart';
import 'package:referral/services/delegate/delegate_service.dart';
import 'package:referral/services/doctor/doctor_service.dart';
import 'package:stacked/stacked.dart';

class YourDelegateViewModel extends BaseViewModel{

	DoctorService get _service => dependency();
	DelegateService get _serviceDel => dependency();

	List<Doctor> doctorList = [];

	void filterHospital(hospital)async{
		doctorList = await _service.getDoctorsByHospital(hospital);
		print("filtering");
		print(doctorList[0].name);
		notifyListeners();
	}

	Future<List<Delegate>> getDelegatesByDoctorId(int id) async{
		print("call delegate func");
		List delegates = await _serviceDel.getDelegateByDoctorId(id);
		print("call succeed");
		return delegates;
	}
}
