import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:referral/ui/viewReferral/investigationInfo_view.dart';
import 'package:referral/ui/viewReferral/patientInfo_view.dart';
import 'package:referral/ui/viewReferral/viewReferral_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ClinicalView extends StatelessWidget {
	static route ({user,  referral}) => MaterialPageRoute(builder: (context)=> ClinicalView(user: user, referral: referral));
	final user, referral;
	ClinicalView({this.user, this.referral});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=>ViewReferralViewModel(), builder: (context, viewmodel, child){
			print(referral.id);
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
																		onTap: (){
														Navigator.pushNamedAndRemoveUntil(
																context, '/homeview', ModalRoute.withName('/'),
																arguments: user);
														
																		},
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
																		Text('Referral Details', style: TextStyle(color: Colors.pink),),
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
																							Expanded(
																									child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children:[
																												Text('Doctor', style: TextStyle(color: Colors.black38)),
																												Text(referral.doctorFromName, style: TextStyle(fontSize:16)),
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
																															onPressed:(){
																																Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientInfoView(user: user, referral: referral)));
																															},
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
																															onPressed:(){
																																Navigator.push(context, MaterialPageRoute(builder: (context)=> InvestigationView(user: user, referral: referral)));
																															},
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
																																child: Text(
																																		referral.notes,
																																),
																														),
																													],
																											),
																									),		
																									Align(
																											alignment: Alignment.bottomCenter,
																											child: Container(
																													width: double.infinity,
																													child: Row(
																															//crossAxisAlignment: CrossAxisAlignment.center,
																															mainAxisAlignment: MainAxisAlignment.center,
																															children: [
																																ElevatedButton(
																																		style: ElevatedButton.styleFrom(

																																				shape: RoundedRectangleBorder(
																																						borderRadius: BorderRadius.circular(10.0),
																																						side: BorderSide(color: Colors.pink)
																																				),
																																				primary: Colors.pink,
																																				onPrimary: Colors.white,
																																		),
																																		onPressed:(){

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
																																																			child:Text("Appointment Details",style:TextStyle(fontSize: 15, color: Colors.pink),textAlign: TextAlign.left,),
																																																	),
																																																	DateTimePicker(
																																																			type: DateTimePickerType.dateTimeSeparate,
																																																			dateMask: 'd MMM, yyyy',
																																																			initialValue: DateTime.now().toString(),
																																																			firstDate: DateTime(2000),
																																																			lastDate: DateTime(2100),
																																																			icon: Icon(Icons.event),
																																																			dateLabelText: 'Date',
																																																			timeLabelText: "Time",
																																																			selectableDayPredicate: (date) {
																																																				// Disable weekend days to select from the calendar
																																																				if (date.weekday == 6 || date.weekday == 7) {
																																																					return false;
																																																				}

																																																				return true;
																																																			},
																																																			onChanged: (val)  {
																																																				//print(val);
																																																				print(DateTime.parse(val).toIso8601String());
																																																				viewmodel.appointmentDate=DateTime.parse(val).toIso8601String();
																																																			},
																																																			validator: (val) {
																																																				//print(val);
																																																				print(DateTime.parse(val).toIso8601String());
																																																				viewmodel.appointmentDate=DateTime.parse(val).toIso8601String();
																																																				return null;
																																																			},
																																																			onSaved: (val) { 
																																																				print("hi");
																																																				print(DateTime.parse(val).toIso8601String());
																																																				viewmodel.appointmentDate=DateTime.parse(val).toIso8601String();
																																																			},
																																																			),
																																																			Container(
																																																					child:Row(
																																																							children:[
																																																								Icon(Icons.location_on, color: Colors.pink),
																																																								SizedBox(width:10),
																																																								Text(user.hospital),
																																																							]
																																																					)
																																																			),
																																																			Align(
																																																					alignment: Alignment.bottomRight,
																																																					child: ElevatedButton(

																																																							onPressed: (){
																																																								viewmodel.setAppointment(referral.id, viewmodel.appointmentDate);
																																																								Navigator.pushNamedAndRemoveUntil(
																																																										context, '/homeview', ModalRoute.withName('/'),
																																																										arguments: user);

																																																							}, child: Text("Confirm")),
																																																			)
																																																					],
																																																					),
																																																					),
																																																					);

																																									});
																																		},
																																		child: Text('Accept', style: TextStyle(color:Colors.white))
																																),
																																SizedBox(width:10),
																																ElevatedButton(
																																		style: ElevatedButton.styleFrom(

																																				shape: RoundedRectangleBorder(
																																						borderRadius: BorderRadius.circular(10.0),
																																						side: BorderSide(color: Colors.pink)
																																				),
																																				primary: Colors.white,
																																				onPrimary: Colors.red,
																																		),
																																		onPressed:(){
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
																																													child:Text("Rejection Remarks",style:TextStyle(fontSize: 15, color: Colors.pink),textAlign: TextAlign.left,),
																																											),
																																											Container(
																																													child: TextField(
																																															keyboardType: TextInputType.multiline,
																																															minLines: 4,
																																															maxLines: 4,
																																															onChanged: (value){
																																																viewmodel.rejectionRemark = value;
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
																																											Align(
																																													alignment: Alignment.bottomRight,
																																											  child: ElevatedButton(

																																											  		onPressed: (){
																																											  			viewmodel.rejectReferral(referral.id, viewmodel.rejectionRemark);
																																											  			Navigator.pushNamedAndRemoveUntil(
																																											  					context, '/homeview', ModalRoute.withName('/'),
																																											  					arguments: user);

																																											  		}, child: Text("Confirm")),
																																											)
																																				],
																																				),
																																				),
																																				);

																																			});},
																													child: Text('Reject', style: TextStyle(color: Colors.pink))
																															),
																													],
																													)
																															)
																															)
																															]
																															))
																															);
		});
	}
}
