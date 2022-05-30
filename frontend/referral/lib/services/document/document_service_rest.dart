import 'package:referral/app/dependencies.dart';
import 'package:referral/model/document.dart';
import 'package:referral/services/document/document_service.dart';
import 'package:referral/services/rest.dart';

class DocumentServiceRest implements DocumentService{
	RestService get rest => dependency();

	Future<List<Document>> getDocumentsByReferralId(int id) async{
		final List listJson = await rest.get('api/Referral/uploadsByReferralId/$id');
		//print(listJson);
		return listJson.map((json)=>Document.fromJson(json)).toList();
	}

	Future<List<Document>> getCompletedDocumentsByReferralId(int id) async{
		final List listJson = await rest.get('api/Referral/completedUploadsByReferralId/$id');
		//print(listJson);
		return listJson.map((json)=>Document.fromJson(json)).toList();
	}
}
