import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:referral/ui/addReferral/referralForm/clinicalInfo/clinical_viewmodel.dart';
import 'package:referral/ui/addReferral/referralForm/investigation/investigation_view.dart';
import 'package:stacked/stacked.dart';

class ClinicalView extends StatelessWidget {
	static route ({user, doctor, patient}) => MaterialPageRoute(builder: (context)=> ClinicalView(user: user, doctor: doctor, patient: patient));
	final user, doctor, patient;
	ClinicalView({this.user, this.doctor, this.patient});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=>ClinicalViewModel(), 
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
																			child:SingleChildScrollView(
																					child: Column(
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
																																					primary: Colors.pink,
																																					onPrimary: Colors.red,
																																			),
																																			onPressed:(){},
																																			child: Text('Clinical Info', style: TextStyle(color: Colors.white, fontSize: 12),),
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
																																			child: Text('Investigation', style: TextStyle(color: Colors.pink, fontSize: 11),),
																																	),
																															),
																													),
																													],
																													),
																													SizedBox(height:20),
																													Column(
																															crossAxisAlignment: CrossAxisAlignment.start,
																															children: [
																																Text('Referral Reason', style: TextStyle(color: Colors.black38)),
																																SizedBox(height:10),
																																Container(
																																		width:200,
																																		height:50,
																																		child: TextField(
																																				onChanged: (value){
																																					viewmodel.reason=value;
																																				},	
																																				decoration: InputDecoration(
																																												isDense:true,
																																												contentPadding: EdgeInsets.all(5),
																																												border: OutlineInputBorder(
																																														borderSide: const BorderSide(color: Colors.pink),
																																														borderRadius: BorderRadius.circular(12),
																																												)
																																										),
																																		),
																																),
																															],
																															),
																															Column(
																																	crossAxisAlignment: CrossAxisAlignment.start,
																																	children: [
																																		Row(
																																				mainAxisAlignment: MainAxisAlignment.spaceBetween,
																																		  children: [
																																		    Text('Clinical History', style: TextStyle(color: Colors.black38)),

																																				Row(
																																						children:[
																																		    			Text('Visible to patient', style: TextStyle(color: Colors.black38)),
																																							SizedBox(width:10),
																																							FlutterSwitch(
																																				  			height:17,
																																				  			width:30,
																																				  			toggleSize: 10,
																																				  			activeColor: Colors.pink,
																																				  			value: viewmodel.chVisibility, 
																																				  			onToggle: (value){
																																				  				viewmodel.chVisibility=value;
																																				  				viewmodel.notifyListeners();
																																				  			},
																																				  			),
																																						] 
																																				)

																																		  ],
																																		),

																																		SizedBox(height:10),
																																		Container(
																																				child: TextField(
																																						keyboardType: TextInputType.multiline,
																																						minLines: 4,
																																						maxLines: 4,
																																						onChanged: (value){
																																							viewmodel.clinicalHistory=value;
																																						},	
																																						decoration: InputDecoration(
																																														isDense:true,
																																														contentPadding: EdgeInsets.all(5),
																																														border: OutlineInputBorder(
																																																borderSide: const BorderSide(color: Colors.pink),
																																																borderRadius: BorderRadius.circular(12),
																																														)
																																												),
																																				),
																																		),
																																		],
																																		),
																																		SizedBox(height:20),
																																		Column(
																																				crossAxisAlignment: CrossAxisAlignment.start,
																																				children: [
																																					Row(
																																							mainAxisAlignment: MainAxisAlignment.spaceBetween,
																																					  children: [
																																					    Text('Diagnosis', style: TextStyle(color: Colors.black38)),
																																				Row(
																																						children:[
																																		    			Text('Visible to patient', style: TextStyle(color: Colors.black38)),
																																							SizedBox(width:10),
																																							FlutterSwitch(
																																				  			height:17,
																																				  			width:30,
																																				  			toggleSize: 10,
																																				  			activeColor: Colors.pink,
																																				  			value: viewmodel.dVisibility, 
																																				  			onToggle: (value){
																																				  				viewmodel.dVisibility=value;
																																				  				viewmodel.notifyListeners();
																																				  			},
																																				  			),
																																						] 
																																				)
																																					  ],
																																					),

																																					SizedBox(height:10),
																																					Container(
																																							child: TextField(
																																									keyboardType: TextInputType.multiline,
																																									minLines: 4,
																																									maxLines: 4,
																																									onChanged: (value){
																																										viewmodel.diagnosis=value;
																																									},	
																																									decoration: InputDecoration(
																																																	isDense:true,
																																																	contentPadding: EdgeInsets.all(5),
																																																	border: OutlineInputBorder(
																																																			borderSide: const BorderSide(color: Colors.pink),
																																																			borderRadius: BorderRadius.circular(12),
																																																	)
																																															),
																																							),
																																					),
																																					],
																																					),		
																																					SizedBox(height:20),
																																					Column(
																																							crossAxisAlignment: CrossAxisAlignment.start,
																																							children: [
																																								Row(
																																										mainAxisAlignment: MainAxisAlignment.spaceBetween,
																																								  children: [
																																								    Text('Notes', style: TextStyle(color: Colors.black38)),
																																				Row(
																																						children:[
																																		    			Text('Visible to patient', style: TextStyle(color: Colors.black38)),
																																							SizedBox(width:10),
																																							FlutterSwitch(
																																				  			height:17,
																																				  			width:30,
																																				  			toggleSize: 10,
																																				  			activeColor: Colors.pink,
																																				  			value: viewmodel.nVisibility, 
																																				  			onToggle: (value){
																																				  				viewmodel.nVisibility=value;
																																				  				viewmodel.notifyListeners();
																																				  			},
																																				  			),
																																						] 
																																				)

																																								  ],
																																								),

																																								SizedBox(height:10),
																																								Container(
																																										child: TextField(
																																												keyboardType: TextInputType.multiline,
																																												minLines: 4,
																																												maxLines: 4,
																																												onChanged: (value){
																																													viewmodel.notes=value;
																																												},	
																																												decoration: InputDecoration(
																																																				isDense:true,
																																																				contentPadding: EdgeInsets.all(5),
																																																				border: OutlineInputBorder(
																																																						borderSide: const BorderSide(color: Colors.pink),
																																																						borderRadius: BorderRadius.circular(12),
																																																				)
																																																		),
																																										),
																																								),
																																								],
																																								),		
																																								Align(
																																										alignment: Alignment.bottomCenter,
																																										child: Container(
																																												width: double.infinity,
																																												child: ElevatedButton(
																																														onPressed:(){
																																															Navigator.push(context, MaterialPageRoute(builder: (context)=> InvestigationView(user: user, doctor: doctor, patient: patient, reason: viewmodel.reason, clinicalHistory: viewmodel.clinicalHistory, diagnosis: viewmodel.diagnosis, notes: viewmodel.notes,)));
																																														},
																																														child: Text('Next')
																																												)
																																										)
																																								)
																																										]
																																										),
																																								)));
				});
	}
}
