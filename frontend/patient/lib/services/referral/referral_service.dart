import 'package:patient/model/referral.dart';

abstract class ReferralService{
	Future<Referral> getReferralById(int id);
	Future<List> listDates(int id);
	Future<List> listDatesByStatus(int id, String status);
	Future<List<Referral>> listReferralByDates(int id, String date);
	Future<List<Referral>> listReferralByDatesAndStatus(int id, String date, String status);
	Future<Referral> denyAppointment(int id);
}
