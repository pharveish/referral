import 'package:flutter/material.dart';
import 'package:referral/ui/registration/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RegistrationView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=> RegistrationViewModel(), 
				builder: (context, viewmodel, child){
					return Scaffold(
							body: Stepper(
									//steps: getSteps(),
									currentStep: viewmodel.currentStep,
									onStepContinue:()async{
										if(viewmodel.currentStep==2){
											await viewmodel.register(viewmodel.username, viewmodel.password, viewmodel.email, viewmodel.name, viewmodel.credentials, viewmodel.specialty, viewmodel.officeNo, viewmodel.mobileNo, viewmodel.fax, viewmodel.hospital);
											Navigator.pushNamedAndRemoveUntil(
													context, '/welcome', ModalRoute.withName('/') 
											);

										}
										viewmodel.currentStep+=1;
										viewmodel.notifyListeners();
									},
									onStepCancel:(){
										if(viewmodel.currentStep==0){
											Navigator.pop(context);
										}
										viewmodel.currentStep-=1;
										viewmodel.notifyListeners();
									},
									steps: [
										Step(
												isActive: viewmodel.currentStep>=0,
												title: Text('General'),
												content: Container(
														padding: EdgeInsets.all(10),
														child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Text("Username", style: TextStyle(fontSize: 17)),
																	SizedBox(height:10),
																	TextField(
																			onChanged: (value){
																				viewmodel.username=value;
																			},	
																			decoration: InputDecoration(
																											hintText: "Choose a unique username",
																											//isDense:true,
																											//contentPadding: EdgeInsets.only(left:10),
																											border: OutlineInputBorder(
																													borderSide: const BorderSide(color: Colors.pink),
																													borderRadius: BorderRadius.circular(10),
																											)
																									),
																	),
																	SizedBox(height:30),
																	Text("Password", style: TextStyle(fontSize: 17)),
																	SizedBox(height:10),
																	TextField(
																			onChanged: (value){
																				viewmodel.password=value;
																			},	
																			obscureText: viewmodel.hidden,
																			decoration: InputDecoration(
																					suffixIcon: IconButton(
																							icon: Icon(Icons.visibility),
																							color: Colors.pink,
																							onPressed:  (){viewmodel.hidden=!viewmodel.hidden;
																								viewmodel.notifyListeners();},
																					),
																					hintText: "Password",
																					//isDense:true,
																					//contentPadding: EdgeInsets.only(left:10),
																					border: OutlineInputBorder(
																							borderSide: const BorderSide(color: Colors.pink),
																							borderRadius: BorderRadius.circular(10),
																					)
																			),
																	),
																	SizedBox(height:30),
																	Text("Full Name", style: TextStyle(fontSize: 17)),
																	SizedBox(height:10),
																	TextField(
																			onChanged: (value){
																				viewmodel.name=value;
																			},	
																			decoration: InputDecoration(
																											hintText: "Include your title eg. Dr.",
																											//isDense:true,
																											//contentPadding: EdgeInsets.only(left:10),
																											border: OutlineInputBorder(
																													borderSide: const BorderSide(color: Colors.pink),
																													borderRadius: BorderRadius.circular(10),
																											)
																									),
																	),
																	SizedBox(height:30),
																	Text("Email", style: TextStyle(fontSize: 17)),
																	SizedBox(height:10),
																	TextField(
																			onChanged: (value){
																				viewmodel.email=value;
																			},	
																			decoration: InputDecoration(
																											hintText: "eg. someone@example.com",
																											//isDense:true,
																											//contentPadding: EdgeInsets.only(left:10),
																											border: OutlineInputBorder(
																													borderSide: const BorderSide(color: Colors.pink),
																													borderRadius: BorderRadius.circular(10),
																											)
																									),
																	),
																	SizedBox(height:30),

																	Text("Credentials", style: TextStyle(fontSize: 17)),
																	SizedBox(height:10),
																	TextField(
																			onChanged: (value){
																				viewmodel.credentials=value;
																			},	
																			decoration: InputDecoration(
																											hintText: "eg. MD(UK) MS ORTH (UM) CMIA (NIOSH)",
																											//isDense:true,
																											//contentPadding: EdgeInsets.only(left:10),
																											border: OutlineInputBorder(
																													borderSide: const BorderSide(color: Colors.pink),
																													borderRadius: BorderRadius.circular(10),
																											)
																									),
																	),
																	SizedBox(height:30),

																	Text("Specialty", style: TextStyle(fontSize: 17)),
																	SizedBox(height:10),
																	DropdownButtonFormField(
																			decoration: InputDecoration(
																					//isDense:true,
																					//contentPadding: EdgeInsets.only(left:10),
																					border: OutlineInputBorder(
																							borderSide: const BorderSide(color: Colors.pink),
																							borderRadius: BorderRadius.circular(10),
																					)
																			),

																			value: viewmodel.specialty,
																			items: viewmodel.specialtyList,
																			onChanged: (value) {
																				viewmodel.specialty = value;
																			},
																	),
																	//SizedBox(height:10),

																	],
																	),
																	),
																	),
																	Step(
																			isActive: viewmodel.currentStep>=1,
																			title: Text('Contact Information'),
																			content: Container(
																					padding: EdgeInsets.all(10),
																					child: Column(
																							crossAxisAlignment: CrossAxisAlignment.start,
																							children: [
																								Text("Office Phone No.", style: TextStyle(fontSize: 17)),
																								SizedBox(height:10),
																								TextField(
																										keyboardType: TextInputType.number,
																										onChanged: (value){
																											viewmodel.officeNo=value;
																										},	
																										decoration: InputDecoration(
																																		hintText: "Office No.",
																																		//isDense:true,
																																		//contentPadding: EdgeInsets.only(left:10),
																																		border: OutlineInputBorder(
																																				borderSide: const BorderSide(color: Colors.pink),
																																				borderRadius: BorderRadius.circular(10),
																																		)
																																),
																								),
																								SizedBox(height:30),

																								Text("Mobile Phone No.", style: TextStyle(fontSize: 17)),
																								SizedBox(height:10),
																								TextField(
																										keyboardType: TextInputType.number,
																										onChanged: (value){
																											viewmodel.mobileNo=value;
																										},	
																										decoration: InputDecoration(
																																		hintText: "Mobile No.",
																																		//isDense:true,
																																		//contentPadding: EdgeInsets.only(left:10),
																																		border: OutlineInputBorder(
																																				borderSide: const BorderSide(color: Colors.pink),
																																				borderRadius: BorderRadius.circular(10),
																																		)
																																),
																								),
																								SizedBox(height:30),

																								Text("Fax No.", style: TextStyle(fontSize: 17)),
																								SizedBox(height:10),
																								TextField(
																										keyboardType: TextInputType.number,
																										onChanged: (value){
																											viewmodel.fax=value;
																										},	
																										decoration: InputDecoration(
																																		hintText: "Fax No.",
																																		//isDense:true,
																																		//contentPadding: EdgeInsets.only(left:10),
																																		border: OutlineInputBorder(
																																				borderSide: const BorderSide(color: Colors.pink),
																																				borderRadius: BorderRadius.circular(10),
																																		)
																																),
																								),
																								SizedBox(height:30),

																								],
																								)
																										),
																								),
																								Step(
																										isActive: viewmodel.currentStep>=2,
																										title: Text('Location'),
																										content: Container(
																												padding: EdgeInsets.all(10),
																												child: Column(
																														crossAxisAlignment: CrossAxisAlignment.start,
																														children: [
																															Text("Hospital", style: TextStyle(fontSize: 17)),
																															SizedBox(height:10),
																															DropdownButtonFormField(
																																	decoration: InputDecoration(
																																			//isDense:true,
																																			contentPadding: EdgeInsets.all(5),
																																			border: OutlineInputBorder(
																																					borderSide: const BorderSide(color: Colors.pink),
																																					borderRadius: BorderRadius.circular(10),
																																			)
																																	),

																																	value: viewmodel.hospital,
																																	items: viewmodel.hospitals,
																																	onChanged: (value) {
																																		viewmodel.hospital = value;
																																	},
																															),
																															//SizedBox(height:10),

																															],
																															),
																															),
																															),
																															]
																																	)
																																	);
				});
	}

	//List<Step> getSteps()=>[
		//	Step(
		//			title: Text('General'),
		//			content: Container(
		//					child: Row(
		//							children: [
			//								TextField(
			//										onChanged: (value){
			//											viewmodel.name=value;
			//										},	
			//										decoration: InputDecoration(
			//																		isDense:true,
			//																		contentPadding: EdgeInsets.only(left:10),
			//																		suffixIcon: IconButton(icon:Icon(Icons.search), onPressed:(){
			//																			viewmodel.getPatientDetails(viewmodel.nric);
			//																			print(viewmodel.patient.patientName);
			//																		}),
			//																		border: OutlineInputBorder(
			//																								borderSide: const BorderSide(color: Colors.pink),
			//																								borderRadius: BorderRadius.circular(12),
			//																						)
			//																),
			//								),

			//							],
			//							)
			//									),
			//							),
			//							Step(
			//									title: Text('Contact Information'),
			//									content: Container(),
			//							),
			//							Step(
			//									title: Text('Location'),
			//									content: Container(),
			//							),
			//							];
}
