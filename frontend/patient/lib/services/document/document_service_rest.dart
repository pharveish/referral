import 'package:patient/app/dependencies.dart';
import 'package:patient/model/document.dart';
import 'package:patient/services/document/document_service.dart';
import 'package:patient/services/rest.dart';

class DocumentServiceRest implements DocumentService{
	RestService get rest => dependency();

	Future<List<Document>> getDocumentsByReferralId(int id) async{
		final List listJson = await rest.get('api/Referral/uploadsByReferralId/$id');
		//print(listJson);
		return listJson.map((json)=>Document.fromJson(json)).toList();
	}

}
