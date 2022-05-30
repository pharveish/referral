import 'package:referral/model/document.dart';

abstract class DocumentService{
	Future<List<Document>> getDocumentsByReferralId(int id);
	Future<List<Document>> getCompletedDocumentsByReferralId(int id);
}
