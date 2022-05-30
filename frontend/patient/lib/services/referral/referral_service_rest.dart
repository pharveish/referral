
	//Future<List> listDates(int id);
	//Future<List> listDatesByStatus(int id);
	//Future<List<Referral>> listReferralByDates(int id, String date);
	//Future<List<Referral>> listReferralByDatesAndStatus(int id, String date, String status);

import 'package:patient/app/dependencies.dart';
import 'package:patient/model/referral.dart';
import 'package:patient/services/referral/referral_service.dart';
import 'package:patient/services/rest.dart';

class ReferralServiceRest implements ReferralService{

	RestService get rest => dependency();

	Future<Referral> getReferralById(int id) async {
		final Map<String, dynamic> referralDetails = await rest.get('api/Referral/referralById/$id');
		if(referralDetails==null){
			return null;
		} else return Referral.fromJson(referralDetails);
	}

	Future<List> listDates(int id) async {
		final List listJson = await rest.get('api/Referral/datesOfPatients/$id');
		return listJson;
	}

	Future<List> listDatesByStatus(int id, String status) async {
		final List listJson = await rest.get('api/Referral/datesOfPatients/$id/$status');
		return listJson;
	}

	Future<List<Referral>> listReferralByDates(int id, String date) async{
		final List listJson = await rest.get('api/Referral/referralByDatePatient/$id/$date');
		return listJson.map((json)=>Referral.fromJson(json)).toList();
	}

	Future<List<Referral>> listReferralByDatesAndStatus(int id, String date, String status) async{
		final List listJson = await rest.get('api/Referral/referralByDatePatientStatus/$id/$date/$status');
		return listJson.map((json)=>Referral.fromJson(json)).toList();
	}

	Future<Referral> denyAppointment(int id) async {
		final Map<String, dynamic> referralJson = await rest.put('api/Referral/denyAppointment/$id');

		final Referral _referral = Referral.fromJson(referralJson);
		return _referral;
	}

}
