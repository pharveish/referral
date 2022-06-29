import 'package:referral/model/referral.dart';

abstract class ReferralService{
	Future<List> listDates(int id);
	Future<List> listHistoryDates(int id);
	Future<List<Referral>> listHistoryByDates(int id, String date);
	Future<List<Referral>> listReferralByDates(int id, String date);
	Future<List> listOutgoingDates(int id);
	Future<List<Referral>> listOutgoingReferralByDates(int id, String date);
	Future<Referral> addReferral(String diagnosis, String notes, String reason, String clinicalHistory, int patientId, int doctorFromId, int doctorToId, String referralDate, bool radiologyExam, bool laboratoryTest, bool followUp);
	Future<Referral> getReferralById(int id);
	Future<Referral> rejectReferral(int id, String rejectionRemark);
	Future<Referral> completeCase(int id, String completionMessage);
	Future<Referral> reassign(int id, int doctorToId);
	Future<Referral> setAppointment(int id, String appointmentDate);
	Future<Referral> abort(int id);
	Future<Referral> denyAppointment(int id);
	Future<Referral> notification(int id);
}
