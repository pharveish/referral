import 'package:referral/app/dependencies.dart';
import 'package:referral/model/document.dart';
import 'package:referral/model/referral.dart';
import 'package:referral/services/document/document_service.dart';
import 'package:referral/services/referral/referral_service.dart';
import 'package:stacked/stacked.dart';

class ViewReferralViewModel extends BaseViewModel {

	ReferralService get _service => dependency();
	DocumentService get _serviceDoc => dependency();
	Referral referral;
	List<Document> documents = [];

	String rejectionRemark= "";
	String appointmentDate="";

	void getReferralById(int id) async{
		referral = await _service.getReferralById(id);
		print("get referral");
		notifyListeners();
	}

	void getDocuments(int id) async{
		documents = await _serviceDoc.getDocumentsByReferralId(id);
		notifyListeners();
	}

	void rejectReferral(int id, String rejectionRemark) async {
		 await _service.rejectReferral(id, rejectionRemark);
		 notifyListeners();
	}

	void setAppointment(int id, String appointmentDate) async {
		 await _service.setAppointment(id, appointmentDate);
		 notifyListeners();
	}

}
