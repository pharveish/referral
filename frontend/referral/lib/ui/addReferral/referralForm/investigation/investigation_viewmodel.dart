import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:referral/app/dependencies.dart';
import 'package:referral/model/fileObject.dart';
import 'package:referral/model/referral.dart';
import 'package:referral/services/referral/referral_service.dart';
import 'package:stacked/stacked.dart';

class InvestigationViewModel extends BaseViewModel{
	InvestigationViewModel();
	ReferralService get _service => dependency();


	List<FileObject> fileObjects= [];
	//List<File> files=[];
	FileObject fileObj = FileObject();
	//get fileObj=> _fileObj;
	//set fileObj(value){
	//	fileObj=value;
	//	notifyListeners();
	//}
	//File _file;
	//get file=> _file;
	//set file(value){
	//	file=value;
	//	notifyListeners();
	//}
	//String _fileName;
	//get fileName=> _fileName;
	//set fileName(value){
	//	fileName=value;
	//	notifyListeners();
	//}
	bool radiologyExam = false;
	bool laboratoryTest = false;
	bool followUp = false;

	void uploadFile(FileObject fileObject) async {
		String fileName = basename(fileObject.file.path);
		print("file base name:$fileName");

		try {
			FormData formData = new FormData.fromMap({
				"files": await MultipartFile.fromFile(fileObject.file.path, filename: fileName),
			});

			//Response response = await Dio().post("http://192.168.118.219:5077/api/Referral/upload/${referral.id}/${fileObject.fileName}",data: formData);
			Response response = await Dio().post("http://192.168.0.16:5077/api/Referral/upload/${referral.id}/${fileObject.fileName}",data: formData);
			print("File upload response: $response");
		} catch (e) {
			print("expectation Caugch: $e");
		}



	}

	Referral referral;

	Future openFile({String url, String fileName}) async {
		await downloadFile(url, fileName);
	}

	Future<File> downloadFile(String url, String name) async {
		final appStorage = await getApplicationDocumentsDirectory();
		final file = File('${appStorage.path}/$name');
		final response = await Dio().post(
				url,
				options: Options(
						responseType: ResponseType.bytes,
						followRedirects: false,
						receiveTimeout: 0,
				)
		);

		final raf = file.openSync(mode: FileMode.write);
		raf.writeFromSync(response.data);
		await raf.close();
		return file;
	}


	void addReferral(String diagnosis, String notes, String reason, String clinicalHistory, int patientId, int doctorFromId, int doctorToId, String referralDate, bool radiologyExam, bool laboratoryTest, bool followUp) async{
		referral = await _service.addReferral(diagnosis, notes, reason, clinicalHistory, patientId, doctorFromId, doctorToId, referralDate, radiologyExam, laboratoryTest, followUp);
		for(int i=0; i<fileObjects.length; i++){
			uploadFile(fileObjects[i]);
		}
		notifyListeners();
	}
}

