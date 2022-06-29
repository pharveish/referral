import 'dart:math';

import 'package:referral/app/dependencies.dart';
import 'package:referral/model/referral.dart';
import 'package:referral/services/referral/referral_service.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends BaseViewModel {

	ReferralService get _service => dependency();

	Future<List> listDates(int id) async{
		//List<DateTime> dates = await _service.listDates(1);
		List dates = await _service.listHistoryDates(id);
		print("outgoing referrals");
//		List<String> dateString =[]; 
		for(int i=0; i<dates.length; i++){
			dates[i].toString().substring(0,min(dates[i].length,10));
			print(dates[i].toString().substring(0,min(dates[i].length,10)));
			
		}
		print(dates);
		return dates;
	}
	Referral referral;
	void getReferralById(int id) async{
		referral = await _service.getReferralById(id);
		print("get referral");
		notifyListeners();
	}

	void abort(int id) async{
		await _service.abort(id);
		notifyListeners();
	}
	String appointmentDate="";

	void setAppointment(int id, String appointmentDate) async {
		 await _service.setAppointment(id, appointmentDate);
		 notifyListeners();
	}

	List dateList = [];
	List<Referral> referralList = [];
	void getDates(int id) async{
	  dateList = await _service.listHistoryDates(id);	
		notifyListeners();
	}

	void getReferrals (int id, String date) async{
		referralList = await _service.listHistoryByDates(id, date);
		notifyListeners();
	}

	Future<List<Referral>> getReferralsByDate(int id, String date) async{
		List referrals = await _service.listHistoryByDates(id, date);
		return referrals;
	}

}
