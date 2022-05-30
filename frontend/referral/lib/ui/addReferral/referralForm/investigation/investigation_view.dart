import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:referral/model/fileObject.dart';
import 'package:referral/ui/addReferral/referralForm/investigation/investigation_viewmodel.dart';
import 'package:referral/ui/home/home_view.dart';
import 'package:stacked/stacked.dart';

class InvestigationView extends StatelessWidget {
	static route ({user, doctor, patient, reason, clinicalHistory, diagnosis, notes}) => MaterialPageRoute(builder: (context)=> InvestigationView(user: user, doctor: doctor, patient: patient, reason: reason, clinicalHistory:clinicalHistory, diagnosis:diagnosis, notes:notes));
	final user, doctor, patient, reason, clinicalHistory, diagnosis, notes;
	InvestigationView({this.user, this.doctor, this.patient, this.reason, this.clinicalHistory, this.diagnosis, this.notes});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=>InvestigationViewModel(), 
				builder: (context, viewmodel, child){
					return Scaffold(
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
																				Text('Add New Referral', style: TextStyle(color: Colors.pink),),
																		),
																	],
																	)
																			),
																	),
																	)

																			),
																	body: Container(
																			padding: EdgeInsets.all(30),
																			child:Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Row(
																					crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									Expanded(
																											child: Column(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children:[
																														Text('Refer To', style: TextStyle(color: Colors.black38)),
																														Text(doctor.hospital, style: TextStyle(fontSize:16)),
																													]
																											),
																									),
																									Expanded(
																											child: Column(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children:[
																														Text('Doctor', style: TextStyle(color: Colors.black38)),
																														Text(doctor.name, style: TextStyle(fontSize:16)),
																													]
																											),
																									)
																								],
																								),
																								Row(
																										children: [
																											Container(
																													padding: EdgeInsets.only(top:25),
																													child: ConstrainedBox(
																															constraints: BoxConstraints.tightFor(width:100, height: 30),
																															child: ElevatedButton(
																																	style: ElevatedButton.styleFrom(

																																			shape: RoundedRectangleBorder(
																																					borderRadius: BorderRadius.circular(10.0),
																																					side: BorderSide(color: Colors.pink)
																																			),
																																			primary: Colors.white,
																																			onPrimary: Colors.red,
																																	),
																																	onPressed:(){},
																																	child: Text('Patient Info', style: TextStyle(color: Colors.pink, fontSize:12),),
																															),
																													),
																											),
																											Container(
																													padding: EdgeInsets.only(top:25, left:10),
																													child: ConstrainedBox(
																															constraints: BoxConstraints.tightFor(width:100, height: 30),
																															child: ElevatedButton(
																																	style: ElevatedButton.styleFrom(

																																			shape: RoundedRectangleBorder(
																																					borderRadius: BorderRadius.circular(10.0),
																																					side: BorderSide(color: Colors.pink)
																																			),
																																			primary: Colors.white,
																																			onPrimary: Colors.red,
																																	),
																																	onPressed:(){},
																																	child: Text('Clinical Info', style: TextStyle(color: Colors.pink, fontSize: 12),),
																															),
																													),
																											),
																											Container(
																													padding: EdgeInsets.only(top:25, left:10),
																													child: ConstrainedBox(
																															constraints: BoxConstraints.tightFor(width:100, height: 30),
																															child: ElevatedButton(
																																	style: ElevatedButton.styleFrom(

																																			shape: RoundedRectangleBorder(
																																					borderRadius: BorderRadius.circular(10.0),
																																					side: BorderSide(color: Colors.pink)
																																			),
																																			primary: Colors.pink,
																																			onPrimary: Colors.red,
																																	),
																																	onPressed:(){},
																																	child: Text('Investigation', style: TextStyle(color: Colors.white, fontSize: 11),),
																															),
																													),
																											),
																											],
																											),
																											SizedBox(height:15),
																											Row(
																													children: [
																														Checkbox(
																																value: viewmodel.radiologyExam, 
																																onChanged: (bool value){
																																	viewmodel.radiologyExam=value;
																																	viewmodel.notifyListeners();
																																}
																																),
																														Text("Radiology Exam"),
																														Checkbox(
																																value: viewmodel.laboratoryTest, 
																																onChanged: (bool value){
																																	viewmodel.laboratoryTest=value;
																																	viewmodel.notifyListeners();
																																}
																																),
																														Text("Laboratory Test"),
																													],
																											),
																											SizedBox(height:5),
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
																																		//print("TESTING");
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
																														)
																													],
																											),
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
																											Row(
																													children: [
																														Checkbox(
																																value: viewmodel.followUp, 
																																onChanged: (bool value){
																																	viewmodel.followUp=value;
																																	viewmodel.notifyListeners();
																																}
																																),
																														Text("Request for Follow-up"),
																													],
																											),
																											Align(
																													alignment: Alignment.bottomCenter,
																													child: Container(
																															width: double.infinity,
																															child: ElevatedButton(
																																	onPressed:(){
																																		viewmodel.addReferral(diagnosis, notes, reason, clinicalHistory, patient.id, user.id, doctor.id, DateTime.now().toIso8601String(), viewmodel.radiologyExam, viewmodel.laboratoryTest, viewmodel.followUp);
																																		//viewmodel.uploadFile(viewmodel.fileObjects[0]);
																																		Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeView(user: user)));
																																	},
																																	child: Text('Confirm')
																															)
																													)
																											)
																													]
																													)));
				});
	}
}
