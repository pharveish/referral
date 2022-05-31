import 'package:referral/app/dependencies.dart';
import 'package:referral/model/delegate.dart';
import 'package:referral/services/delegate/delegate_service.dart';
import 'package:referral/services/rest.dart';

class DelegateServiceRest implements DelegateService{
	RestService get rest => dependency();	


	Future<List<Delegate>> getDelegateByDoctorId(int id) async {
		print("in service");
		final List listJson = await rest.get('api/Delegate/delegates/$id');
		print(listJson);
		return listJson.map((json)=>Delegate.fromJson(json)).toList();
	}

	Future<Delegate> addToDelegates(int doctorFromId, int doctorToId)async{
		final Map<String, dynamic> delegateJson = await rest.post('api/Delegate', data: {
			"delegateFromId":doctorFromId,
			"delegateToId":doctorToId,
		});
		final Delegate _doctor = Delegate.fromJson(delegateJson);
		return _doctor;
	}

}
