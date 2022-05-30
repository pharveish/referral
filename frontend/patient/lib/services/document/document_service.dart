
import 'package:patient/model/document.dart';

abstract class DocumentService{
	Future<List<Document>> getDocumentsByReferralId(int id);
}
