import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:referral/app/dependencies.dart';
import 'package:referral/model/document.dart';
import 'package:referral/model/fileObject.dart';
import 'package:referral/services/document/document_service.dart';
import 'package:referral/services/referral/referral_service.dart';
import 'package:stacked/stacked.dart';

class CompleteCaseViewModel extends BaseViewModel{
	ReferralService get _service => dependency();
	DocumentService get _serviceDoc => dependency();


	List<FileObject> fileObjects= [];
	//List<File> files=[];
	FileObject fileObj = FileObject();

	
	String completionMessage="";
	List<Document> documents = [];


	void uploadFile(FileObject fileObject, int id) async {
		String fileName = basename(fileObject.file.path);
		print("file base name:$fileName");

		try {
			FormData formData = new FormData.fromMap({
				"files": await MultipartFile.fromFile(fileObject.file.path, filename: fileName),
			});

			Response response = await Dio().post("http://192.168.118.219:5077/api/Referral/upload/completed/$id/${fileObject.fileName}",data: formData);
			//Response response = await Dio().post("http://192.168.68.107:5077/api/Referral/upload/completed/$id/${fileObject.fileName}",data: formData);
			print("File upload response: $response");
		} catch (e) {
			print("expectation Caugch: $e");
		}



	}
	void completeCase(int id, String completionMessage) async{
		 await _service.completeCase(id, completionMessage);
		for(int i=0; i<fileObjects.length; i++){
			uploadFile(fileObjects[i],id);
		}
		notifyListeners();
	}

	void getDocuments(int id) async{
		documents = await _serviceDoc.getCompletedDocumentsByReferralId(id);
		notifyListeners();
	}

}
