import 'package:referral/app/dependencies.dart';
import 'package:referral/model/referral.dart';
import 'package:referral/services/referral/referral_service.dart';
import 'package:referral/services/rest.dart';

class ReferralServiceRest implements ReferralService{
	RestService get rest => dependency();
	Future<List> listDates(int id) async {
		print("service starts");
		final List listJson = await rest.get('api/Referral/datesOfReferredTo/$id');
		print(listJson);
		//print(listJson.map((json)=> Referral.fromJson(json)).toList());
		//		return listJson.map((json)=> Referral.fromJson(json)).toList();
		print('gonna return');
		return listJson;
	}

	Future<List> listHistoryDates(int id) async {
		print("service starts");
		final List listJson = await rest.get('api/Referral/datesHistory/$id');
		print(listJson);
		//print(listJson.map((json)=> Referral.fromJson(json)).toList());
		//		return listJson.map((json)=> Referral.fromJson(json)).toList();
		print('gonna return');
		return listJson;
	}

	Future<List> listOutgoingDates(int id) async {
		print("service starts");
		final List listJson = await rest.get('api/Referral/datesOfReferredReferredFrom/$id');
		print(listJson);
		//print(listJson.map((json)=> Referral.fromJson(json)).toList());
		//		return listJson.map((json)=> Referral.fromJson(json)).toList();
		print('gonna return');
		return listJson;
	}

	Future<List<Referral>> listHistoryByDates(int id, String date) async{
		final List listJson = await rest.get('api/Referral/referralHistoryByDate/$id/$date');
		print(listJson);
		return listJson.map((json)=>Referral.fromJson(json)).toList();
	}
	Future<List<Referral>> listReferralByDates(int id, String date) async{
		final List listJson = await rest.get('api/Referral/referralByDate/$id/$date');
		print(listJson);
		return listJson.map((json)=>Referral.fromJson(json)).toList();
	}

	Future<List<Referral>> listOutgoingReferralByDates(int id, String date) async{
		final List listJson = await rest.get('api/Referral/referralByDateDoctorFrom/$id/$date');
		print(listJson);
		return listJson.map((json)=>Referral.fromJson(json)).toList();
	}

	Future<Referral> addReferral(String diagnosis, String notes, String reason, String clinicalHistory, int patientId, int doctorFromId, int doctorToId, referralDate, bool radiologyExam, bool laboratoryTest, bool followUp) async {
		final Map<String, dynamic> referralJson = await rest.post('api/Referral', data: {
			"diagnosis":diagnosis,
			"notes":notes,
			"reason":reason,
			"clinicalHistory":clinicalHistory,
			"patientId":patientId,
			"doctorFromId":doctorFromId,
			"doctorToId":doctorToId,
			"referralDate":referralDate,
			"radiologyExam":radiologyExam,
			"laboratoryTest":laboratoryTest,
			"followUp":followUp,
		});
		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}

	Future<Referral> getReferralById(int id) async {
		final Map<String, dynamic> referralDetails = await rest.get('api/Referral/referralById/$id');
		if(referralDetails==null){
			return null;
		} else return Referral.fromJson(referralDetails);
	}

	Future<Referral> rejectReferral(int id, String rejectionRemark) async {
		final Map<String, dynamic> referralJson = await rest.put('api/Referral/reject/$id', data:{
			"rejectionRemark": rejectionRemark,
		});
		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}

	Future<Referral> completeCase(int id, String completionMessage) async {
		final Map<String, dynamic> referralJson = await rest.put('api/Referral/completeCase/$id', data:{
			"completionMessage": completionMessage,
		});
		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}

	Future<Referral> setAppointment(int id, String appointmentDate) async {
		final Map<String, dynamic> referralJson = await rest.put('api/Referral/setAppointment/$id', data:{
			"appointmentDate": appointmentDate,
		});
		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}

	Future<Referral> reassign(int id, int doctorToId) async {
		final Map<String, dynamic> referralJson = await rest.put('api/Referral/reassign/$id', data:{
			"doctorToId": doctorToId,
		});

		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}

	Future<Referral> abort(int id) async {
		final Map<String, dynamic> referralJson = await rest.put('api/Referral/abort/$id');

		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}
	Future<Referral> denyAppointment(int id) async {
		final Map<String, dynamic> referralJson = await rest.put('api/Referral/denyAppointment/$id');

		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}
	Future<Referral> notification(int id) async {
		final Map<String, dynamic> referralJson = await rest.post('api/Referral/notification/$id');

		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}

}
