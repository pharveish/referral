import 'package:stacked/stacked.dart';

class ClinicalViewModel extends BaseViewModel{
	ClinicalViewModel();
	String reason = "";
	String clinicalHistory = "";
	String diagnosis = "";
	String notes = "";

	bool chVisibility = false;
	bool dVisibility = false;
	bool nVisibility = false;
}
