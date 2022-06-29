import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:referral/model/fileObject.dart';
import 'package:referral/ui/completeCase/complete_viewmodel.dart';
import 'package:referral/ui/home/home_view.dart';
import 'package:stacked/stacked.dart';

class CompleteCaseView extends StatelessWidget {
	static route ({user, referral, isViewing}) => MaterialPageRoute(builder: (context)=> CompleteCaseView (user: user, referral: referral, isViewing: isViewing));
	final user, referral, isViewing;
	CompleteCaseView ({this.user, this.referral, this.isViewing});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=>CompleteCaseViewModel(), builder: (context, viewmodel, child){
			if(isViewing==true){
				viewmodel.getDocuments(referral.id);
			}
			return Scaffold(
					resizeToAvoidBottomInset: false,
					appBar: AppBar(
							automaticallyImplyLeading: false,
							backgroundColor: Colors.white,
							toolbarHeight: 70.0,
							title: Container(
									padding: EdgeInsets.only(top:35),
									child: ListTile(
											leading: CircleAvatar(
													backgroundImage: NetworkImage('https://www.pngitem.com/pimgs/m/455-4554771_doctor-png-female-doctor-transparent-background-png-download.png'),
											),
											title:Text('${user.name}'),
											subtitle: Text('${user.credentials}'),
									),
							),
							flexibleSpace: Container(
									decoration: BoxDecoration(
											image: DecorationImage(
													image: AssetImage(
															'lib/assets/appBar.png'
													),
													fit: BoxFit.cover,
											)
									),
							),
							bottom: PreferredSize(
									preferredSize:  const Size.fromHeight(70.0),
									child: Container(
											height: 40,
											child: ColoredBox(
													color: Colors.white,
													child: Row(
															children: [
																InkWell(
																		onTap: ()=>Navigator.pop(context),
																		child: Container(
																				padding: EdgeInsets.only(left:20, right: 20),
																				child:
																				Row(
																						children: [
																							Icon(Icons.chevron_left, color: Colors.pink,),
																							Text('Back', style: TextStyle(color: Colors.pink)),
																						],
																				),
																		),
																),
																Container(
																		padding: EdgeInsets.only(left:45),
																		child:
																		Text('Referral Reply', style: TextStyle(color: Colors.pink),),
																),
															],
															)
																	),
															),
															)

																	),	
															body: Container(
																	padding: EdgeInsets.all(30),
																	child: isViewing==false?Column(
																			crossAxisAlignment: CrossAxisAlignment.start,
																			children: [
																				Row(
																						children: [
																							Expanded(
																									child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children:[
																												Text('Patient Name', style: TextStyle(color: Colors.black38)),
																												Text(referral.patientName, style: TextStyle(fontSize:16)),
																											]
																									),
																							),
																							Expanded(
																									child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children:[
																												Text('Identification No.', style: TextStyle(color: Colors.black38)),
																												Text(referral.patientIc, style: TextStyle(fontSize:16)),
																											]
																									),
																							)
																						],
																						),
																						SizedBox(height:20),
																						Text('Message', style: TextStyle(color: Colors.black38)),
																						SizedBox(height:10),
																						Container(
																								child: TextField(
																										keyboardType: TextInputType.multiline,
																										minLines: 12,
																										maxLines: 12,
																										onChanged: (value){
																											viewmodel.completionMessage = value;
																										},	
																										decoration: InputDecoration(
																																		//isDense:true,
																																		//contentPadding: EdgeInsets.all(5),
																																		border: OutlineInputBorder(
																																				borderSide: const BorderSide(color: Colors.pink),
																																				borderRadius: BorderRadius.circular(10),
																																		)
																																),
																								),
																						),
																						SizedBox(height:20),
																											Row(
																													mainAxisAlignment: MainAxisAlignment.spaceBetween,
																													children: [
																														Text('Attachment(s)', style: TextStyle(color: Colors.black38)),
																														InkWell(
																																onTap: (){
																																	FileObject fileObj = FileObject();
																																	showDialog(context: context, builder: (BuildContext context){
																																				return Dialog(
																																						child: Container(
																																								padding: EdgeInsets.all(10),
																																								height: 200,
																																								child: Column(
																																										mainAxisAlignment: MainAxisAlignment.spaceBetween,
																																										children: [
																																											Align(
																																													alignment: Alignment.topLeft,
																																													child:Text("Upload File",style:TextStyle(fontSize: 15, color: Colors.pink),textAlign: TextAlign.left,),
																																											),
																																											Container(
																																													child: TextField(
																																															onChanged: (value){
																																																fileObj.fileName = value;
																																															},	
																																															decoration: InputDecoration(
																																																							isDense:true,
																																																							contentPadding: EdgeInsets.all(5),
																																																							border: OutlineInputBorder(
																																																									borderSide: const BorderSide(color: Colors.pink),
																																																									borderRadius: BorderRadius.circular(10),
																																																							)
																																																					),
																																													),
																																											),
																																											ElevatedButton(
																																	onPressed:()async{
																																		//FileObject fileObj;
																																		File selectedFile;
																																		selectedFile= await FilePicker.getFile();
																																		print("TESTING");
																																		//print(basename(selectedFile.path));
																																		//fileObj.file = selectedFile;
																																		fileObj.file= selectedFile;
																																		//viewmodel.objectFile[0] = selectedFile;
																																	},
																																	child: Text('Pick File')
																															),
																																											Align(
																																													alignment: Alignment.bottomRight,
																																											  child: ElevatedButton(

																																											  		onPressed: (){
																																															viewmodel.fileObjects.add(fileObj);
																																															print(viewmodel.fileObjects.length);
																																															for(int i=0; i<viewmodel.fileObjects.length;i++){
																																																print(viewmodel.fileObjects[i].fileName);
																																															}
																																															//viewmodel.fileObject=null;
																																															Navigator.pop(context);
																																															viewmodel.notifyListeners();
																																											  		}, child: Text("Confirm")),
																																											)
																																				],
																																				),
																																				),
																																				);

																																			}	
																																	);
																																},
																														  child: Container(
																														  		child:Row(
																														  				children: [
																														  					Icon(Icons.cloud_upload_outlined, color: Colors.pink),
																														  					SizedBox(width:5),
																														  					Text("Upload File" ,textAlign: TextAlign.right)
																														  				],
																														  		)
																														  ),
																														),
																													],
																											),
																											SizedBox(height:10),
																											Expanded(
																											  child: Container(
																											    child: ListView.builder(
																											    		itemCount: viewmodel.fileObjects.length,
																											    		itemBuilder:(context, index){
																											    			return Card(
																																		child: ListTile(
																																				leading: Icon(Icons.file_copy_outlined),
																											    			  		title: Text(viewmodel.fileObjects[index].fileName),
																																			trailing: Icon(Icons.delete_sharp, color: Colors.pink),
																											    			  ),
																											    			);
																											    		} ),
																											  ),
																											),
																											Align(
																													alignment: Alignment.bottomCenter,
																													child: Container(
																															child: ElevatedButton(
																																					style: ElevatedButton.styleFrom(

																																							shape: RoundedRectangleBorder(
																																									borderRadius: BorderRadius.circular(10.0),
																																									side: BorderSide(color: Colors.pink)
																																							),
																																							primary: Colors.pink,
																																							onPrimary: Colors.red,
																																					),
																																	onPressed:(){
																																		viewmodel.completeCase(referral.id, viewmodel.completionMessage);
																																		//viewmodel.uploadFile(viewmodel.fileObjects[0]);
																																		Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeView(user: user)));
																																	},
																																	child: Text('Discharge', style: TextStyle(color:Colors.white))
																															)
																													)
																											)

																			],
																	):Column(
																			crossAxisAlignment: CrossAxisAlignment.start,
																			children: [
																				Row(
																						children: [
																							Expanded(
																									child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children:[
																												Text('Patient Name', style: TextStyle(color: Colors.black38)),
																												Text(referral.patientName, style: TextStyle(fontSize:16)),
																											]
																									),
																							),
																							Expanded(
																									child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children:[
																												Text('Identification No.', style: TextStyle(color: Colors.black38)),
																												Text(referral.patientIc, style: TextStyle(fontSize:16)),
																											]
																									),
																							)
																						],
																						),
																						SizedBox(height:20),
																						Text('Message', style: TextStyle(color: Colors.black38)),
																						Expanded(
																								child:
																						Text(referral.completionMessage, style: TextStyle(fontSize:16)),
																						),
																						SizedBox(height:20),
																						Text('Attachment(s)', style: TextStyle(color: Colors.black38)),
																						SizedBox(height:20),
																									Expanded(
																											child: ListView.builder(
																													itemCount: viewmodel.documents.length,
																													itemBuilder: (context, index){
																														return Card(
																																child: ListTile(
																																		leading: Icon(Icons.file_copy),
																																		title: Text(viewmodel.documents[index].fileName),				
																																		trailing: InkWell(
																																				onTap:()async{
																																					final status = await Permission.storage.request();
																																					if(status.isGranted){
																																						final externalDir = await getExternalStorageDirectory();
																																						final id = await FlutterDownloader.enqueue(
																																								//url:"http://192.168.118.219:5077/api/Referral/download/completed/${viewmodel.documents[index].id}/${referral.id}",
																																								//url:"https://referralapp.effronsoftware.com/api/Referral/download/completed/${viewmodel.documents[index].id}/${referral.id}",
																																								url:"http://192.168.68.105:5077/api/Referral/download/completed/${viewmodel.documents[index].id}/${referral.id}",
																																								//url:"http://192.168.68.107:5077/api/Referral/download/${viewmodel.documents[index].id}/${referral.id}",
																																								savedDir: externalDir.path,
																																								fileName: "${viewmodel.documents[index].fileName}",
																																								showNotification: true,
																																								openFileFromNotification: true,
																																						);
																																					} else {
																																						print("Permission denied");
																																					}
																																				},
																																				child: Icon(Icons.download, color: Colors.pink)
																																		)
																																),
																														);
																													}
																											)
																									),

																			],
																	),

															)

			);
		});
	}
}
