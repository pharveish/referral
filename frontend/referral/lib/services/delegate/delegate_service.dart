import 'package:referral/model/delegate.dart';

abstract class DelegateService{
	Future<Delegate> addToDelegates(int delegateFromId, int delegateToId);
	Future<List<Delegate>> getDelegateByDoctorId(int id);
}
