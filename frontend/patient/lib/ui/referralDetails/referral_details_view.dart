import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patient/ui/components/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class ReferralDetailsView extends StatelessWidget {
	static route ({user, referral, documents}) => MaterialPageRoute(builder: (context)=> ReferralDetailsView(user: user, referral:referral, documents:documents));
	final user, referral, documents;
	ReferralDetailsView({this.user, this.referral, this.documents});
	@override
	Widget build(BuildContext context) {
		//return ViewModelBuilder.reactive(viewModelBuilder: ()=> ReferralDetailsViewModel(), 
		//		builder: (context, viewmodel, child){
		return DefaultTabController(
				length:3,
				child: Scaffold(
						appBar: AppBar(
								backgroundColor: Colors.white,
								elevation:0,
								toolbarHeight: 100,
								title: Text("Referral Details"),
								centerTitle: true,
								flexibleSpace: Container(
										decoration: BoxDecoration(
												color: kPrimaryColor,
												borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
										),
								),
						),
						body: Container(
								padding: EdgeInsets.all(30),
								child: 
								Column(
										children: [
											Container(
													padding: EdgeInsets.all(10),
													child: Row(
															crossAxisAlignment: CrossAxisAlignment.start,
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																Expanded(
																		child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children:[
																					Text('Refer From', style: TextStyle(color: Colors.black38)),
																					Text(referral.referToHospital, style: TextStyle(fontSize:16)),
																				]
																		),
																),
																Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children:[
																			Text('Doctor', style: TextStyle(color: Colors.black38)),
																			Text(referral.doctorFromName, style: TextStyle(fontSize:16)),
																		]
																)
															],
															),
															),
															SizedBox(height:20),
															TabBar(
																	labelColor: Colors.black,
																	unselectedLabelColor: Colors.black54,
																	indicatorColor: kPrimaryColor,
																	indicator: UnderlineTabIndicator(
																			borderSide: BorderSide(width:3, color: kPrimaryColor ),
																	),
																	tabs:[
																		Tab(text: "Patient Info"),
																		Tab(text: "Clinical Info"),
																		Tab(text: "Investigation"),
																	]
															),
															Expanded(
																	child: TabBarView(children: [
																		// PATIENT INFO VIEW
																			Container(
																					padding: EdgeInsets.all(10),
																					child: Column(
																							crossAxisAlignment: CrossAxisAlignment.start,
																							children:[

	SizedBox(height:30),
	Text('Identification No.', style: TextStyle(color: Colors.black38), textAlign: TextAlign.start,),
	Text(referral.patientIc, style: TextStyle(fontSize:16)),
	SizedBox(height:10),
	SizedBox(height:20),
	Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children:[
				Text('Patient Name', style: TextStyle(color: Colors.black38)),
				Text(referral.patientName, style: TextStyle(fontSize:16)),
			]
	),
	SizedBox(height:20),
	Row(
			children: [
				Expanded(
						child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children:[
									Text('Gender', style: TextStyle(color: Colors.black38)),
									Text(referral.patientGender, style: TextStyle(fontSize:16))
								]
						),
				),
				//SizedBox(width:80),
				Expanded(
						child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children:[
									Text('Mobile No', style: TextStyle(color: Colors.black38)),
									Text(referral.patientMobileNo, style: TextStyle(fontSize:16)),
								]
						),
				)
			],
			),
			SizedBox(height:20),
			Row(
					children: [
						Expanded(
								child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children:[
											Text('Home No', style: TextStyle(color: Colors.black38)),
											Text(referral.patientHomeNo, style: TextStyle(fontSize:16)),
										]
								),
						),
						Expanded(
								child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children:[
											Text('Mobile No', style: TextStyle(color: Colors.black38)),
											Text(referral.patientMobileNo, style: TextStyle(fontSize:16)),
										]
								),
						)
					],
					),
					SizedBox(height:20),
					Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children:[
								Text('E-mail', style: TextStyle(color: Colors.black38)),
								Text(referral.patientEmail, style: TextStyle(fontSize:16)),
							]
					),
					SizedBox(height:20),
					Expanded(
							child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children:[
										Text('Address', style: TextStyle(color: Colors.black38)),
										Container(
												width:200,
												child:
												Text(referral.patientAddress, style: TextStyle(fontSize:16)),
										)
									]
							),
					),
					])
							),

					// CLINICAL INFO
					Container(
							padding: EdgeInsets.all(10),
							child:Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										SizedBox(height:30),
										Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text('Referral Reason', style: TextStyle(color: Colors.black38)),
													SizedBox(height:10),
													Container(
															width:200,
															height:50,
															child: Text(
																	referral.reason,
															),
													),
												],
										),
										Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text('Clinical History', style: TextStyle(color: Colors.black38)),
													SizedBox(height:10),
													Container(
															width:200,
															height:50,
															child: Text(
																	referral.clinicalHistory,
															),
													),
												],
										),
										SizedBox(height:20),
										Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text('Diagnosis', style: TextStyle(color: Colors.black38)),
													SizedBox(height:10),
													Container(
															width:200,
															height:50,
															child: Text(
																	referral.diagnosis,
															),
													),
												],
										),		
										SizedBox(height:20),
										Expanded(
												child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [
															Text('Notes', style: TextStyle(color: Colors.black38)),
															SizedBox(height:10),
															Container(
															width:200,
															height:50,
																	child: Text(
																			referral.notes,
																	),
															),
														],
												),
										),		
										],
										)
												),

										//INVESTIGATION
										Container(
												padding: EdgeInsets.all(10),
												child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [

																									SizedBox(height:30),
																											Row(
																													children: [
																														Checkbox(
																																value: referral.radiologyExam, 
																																onChanged: null
																																),
																														Text("Radiology Exam"),
																														Checkbox(
																																value: referral.laboratoryTest, 
																																onChanged: null,
																																),
																														Text("Laboratory Test"),
																													],
																											),
																									SizedBox(height:10),
																									Text("Attachment(s)"),
																									SizedBox(height:10),
																									Expanded(
																											child: ListView.builder(
																													itemCount: documents.length,
																													itemBuilder: (context, index){
																														return Card(
																																child: ListTile(
																																		leading: Icon(Icons.file_copy),
																																		title: Text(documents[index].fileName),				
																																		trailing: InkWell(
																																				onTap:()async{
																																					final status = await Permission.storage.request();
																																					if(status.isGranted){
																																						final externalDir = await getExternalStorageDirectory();
																																						final id = await FlutterDownloader.enqueue(
																																								//url:"http://192.168.68.107:5077/api/Referral/download/${documents[index].id}/${referral.id}",
																																								url:"https://referralapp.effronsoftware.com/api/Referral/download/${documents[index].id}/${referral.id}",
																																								//url:"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png",
																																								savedDir: externalDir.path,
																																								fileName: "${documents[index].fileName}",
																																								showNotification: true,
																																								openFileFromNotification: true,
																																						);
																																					} else {
																																						print("Permission denied");
																																					}
																																				},
																																				child: Icon(Icons.download, color: kPrimaryColor)
																																		)
																																),
																														);
																													}
																											)
																									),
														],
												)
										),
										],),
										)
												],
												),
												)),
												);
												//		}
												//);
	}
}
