import 'dart:math';

import 'package:patient/app/dependencies.dart';
import 'package:patient/model/document.dart';
import 'package:patient/model/referral.dart';
import 'package:patient/services/document/document_service.dart';
import 'package:patient/services/referral/referral_service.dart';
import 'package:stacked/stacked.dart';


class HistoryViewModel extends BaseViewModel{
	List<Document> documents = [];
  ReferralService get _service => dependency();
	DocumentService get _serviceDoc => dependency();

  Future<List> listDates(int id, ) async {
    List dates = await _service.listDates(id);
    for (int i = 0; i < dates.length; i++) {
      dates[i].toString().substring(0, min(dates[i].length, 10));
    }
    return dates;
  }

  Future<List<Referral>> getReferralsByDate(int id, String date ) async {
    List referrals =
        await _service.listReferralByDates(id, date );
    return referrals;
  }

	Referral referral;

	void getReferralById(int id)async{
		referral = await _service.getReferralById(id);
		notifyListeners();
	}
	void getDocuments(int id) async{
		documents = await _serviceDoc.getDocumentsByReferralId(id);
		notifyListeners();
	}

}
