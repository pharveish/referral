import 'dart:math';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:referral/ui/addReferral/category/category_view.dart';
import 'package:referral/ui/completeCase/complete_view.dart';
import 'package:referral/ui/delegate/your_delegate_view.dart';
import 'package:referral/ui/home/tabviews/referredin/referredin_viewmodel.dart';
import 'package:referral/ui/viewReferral/patientInfo_view.dart';
import 'package:stacked/stacked.dart';

class ReferredInView extends StatelessWidget {
	static route ({user}) => MaterialPageRoute(builder: (context)=> ReferredInView(user: user));
	final user;
	ReferredInView({this.user});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<ReferredInViewModel>.reactive(viewModelBuilder: ()=>ReferredInViewModel(), 
				builder: (context, viewmodel, child){
					return Container(
							height: MediaQuery.of(context).size.height,
							padding: EdgeInsets.all(10),
							color: Colors.grey[200],
							child: FutureBuilder(
									future: viewmodel.listDates(user.id),
									builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
										if(snapshot.hasData){
											List dates = snapshot.data;
											return ListView.builder(
													itemCount: dates.length, 
													itemBuilder: (BuildContext context, int index){
														String formattedDate=dates[index].toString().substring(0,min(dates[index].length,10));
														return Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Container(
																			padding: EdgeInsets.only(left:20, top:20),
																			child: Text(formattedDate)
																	),
																	Container(
																			//height: heightLength,
																			padding: EdgeInsets.all(10),
																			//alignment: Alignment.centerLeft,
																			child: FutureBuilder(
																					future: viewmodel.getReferralsByDate(user.id, formattedDate),
																					builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
																						if(snapshot.hasData){
																							List referrals = snapshot.data;
																							return ListView.builder(
																									physics: NeverScrollableScrollPhysics(),
																									shrinkWrap:true,
																									itemCount: referrals.length,
																									itemBuilder: (BuildContext context, int index){
																										return InkWell(
																												onTap:(){
																													if(referrals[index].status=="Pending")Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientInfoView(user: user, referral: referrals[index], )));

																												},
																												child: Container(
																																	 padding: EdgeInsets.all(10),
																																	 margin: EdgeInsets.only(bottom:15),
																																	 decoration: BoxDecoration(
																																			 boxShadow: [
																																				 BoxShadow( color: Colors.grey[600],
																																						 blurRadius: 2.0,
																																						 spreadRadius: 0.0,
																																						 offset: Offset(0.0, 3.0),)
																																			 ],
																																			 color: Colors.white,
																																			 border: Border.all(color: Colors.white),

																																			 borderRadius: BorderRadius.circular(20),
																																	 ),
																																	 child: Column(
																																			 crossAxisAlignment: CrossAxisAlignment.start,
																																			 children: [
																																				 Row(
																																						 children:[
																																							 Expanded(
																																									 child: Column(
																																											 crossAxisAlignment: CrossAxisAlignment.start,
																																											 children: [
																																												 Text('Referral No', textAlign: TextAlign.left, 
																																														 style: TextStyle(
																																																 color: Colors.black38
																																														 )),
																																												 Text('0-00-000${referrals[index].id}', textAlign: TextAlign.left),
																																												 SizedBox(height:5),
																																												 Text('Patient Name', textAlign: TextAlign.left, 
																																														 style: TextStyle(
																																																 color: Colors.black38
																																														 )),
																																												 Text(referrals[index].patientName, textAlign: TextAlign.left),
																																												 SizedBox(height:5),
																																												 Text('Reason', textAlign: TextAlign.left, 
																																														 style: TextStyle(
																																																 color: Colors.black38
																																														 )),
																																												 Text(referrals[index].reason, textAlign: TextAlign.left),
																																												 SizedBox(height:5),
																																												 //if(referrals[index].status=="Rejected")
																																												 //	ExpansionTile(
																																												 //		title:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.red)),
																																												 //		children:[
																																													 //			Text("Le remark")
																																													 //		],
																																													 //	),
																																													 //if(referrals[index].status=="Pending")
																																													 //Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.yellow[700])),
																																							 ],
																																							 ),
																																							 ),	
																																							 Expanded(
																																									 child: Column(
																																											 crossAxisAlignment: CrossAxisAlignment.start,
																																											 children: [
																																												 Text('Referral Date', textAlign: TextAlign.left, 
																																														 style: TextStyle(
																																																 color: Colors.black38
																																														 )),
																																												 Text(formattedDate, textAlign: TextAlign.left),
																																												 SizedBox(height:5),
																																												 Text('Identification No.', textAlign: TextAlign.left, 
																																														 style: TextStyle(
																																																 color: Colors.black38
																																														 )),
																																												 Text(referrals[index].patientIc, textAlign: TextAlign.left),
																																												 SizedBox(height:5),
																																												 Text('Referral To', textAlign: TextAlign.left, 
																																														 style: TextStyle(
																																																 color: Colors.black38
																																														 )),
																																												//if(referrals[index].followUp==true){
																																												 Row(
																																														 mainAxisAlignment: MainAxisAlignment.spaceBetween,
																																														 children: [
																																															 Flexible(
																																																	 child:
																																												 				Text(user.hospital, textAlign: TextAlign.left),
																																															 ),
																																																referrals[index].followUp==true?Icon(Icons.warning_rounded, color:Colors.yellow[700]):Text(""),
																																														 ],
																																												 ),
																																												//}
																																												 SizedBox(height:5),
																																												 //Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.white)),

																																												 ],
																																												 ),
																																												 ),	
																																												 ]
																																														 ),
																																												 if(referrals[index].status=="Rejected")
																																													 ListTileTheme(
																																															 contentPadding: EdgeInsets.all(0),
																																															 dense: true,
																																															 horizontalTitleGap: 0.0,
																																															 minLeadingWidth: 0,
																																															 child: ExpansionTile(
																																																	 title:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.red, fontSize: 14)),
																																																	 children:[
																																																		 Align(
																																																				 alignment: Alignment.topLeft,
																																																				 child: Container(
																																																						 padding: EdgeInsets.only(top:15, bottom:15),
																																																						 child:Text(referrals[index].rejectionRemark ),),
																																																		 )
																																																	 ],
																																															 ),
																																													 ),
																																														 if(referrals[index].status=="Pending")
																																															 Row(
																																																	 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																	 children: [
																																																		 Container(
																																																				 padding: EdgeInsets.only(top:15, bottom:15),
																																																				 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.yellow[700], fontSize: 14)),
																																																		 ),
																																																		 PopupMenuButton(
																																																				 icon:Icon(Icons.more_horiz, color: Colors.black),
																																																				 itemBuilder: (context){
																																																					 return [
																																																						 PopupMenuItem(
																																																								 value:0,
																																																								 child: Text('Refer Out')),	
																																																						 PopupMenuItem(
																																																								 value:1,
																																																								 child: Text('Referral Reply', style:TextStyle(color:Colors.black38))),	
																																																						 PopupMenuItem(
																																																								 value:2,
																																																								 child: Text('Delegate')),	
																																																					 ];
																																																				 },
																																																				 onSelected:(value)async{
																																																					 if(value==0){
																																																							await viewmodel.getReferralById(referrals[index].id);
																																																							Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryView(user: user, referral: viewmodel.referral, )));

																																																					 }
																																																					 if(value==2){
																																																							await viewmodel.getReferralById(referrals[index].id);
																																																							Navigator.push(context, MaterialPageRoute(builder: (context)=> YourDelegateView(user: user, referral: viewmodel.referral, )));

																																																					 }
																																																				 }

																																																		 )
																																																				 ],
																																																				 ),
																																																																			 if(referrals[index].status=="Aborted")
																																																																				 Container(
																																																																						 padding: EdgeInsets.only(top:15, bottom:15),
																																																																						 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.red[700], fontSize: 14)),
																																																																				 ),
																																																																			 if(referrals[index].status=="Appointment Denied")
																																																																				 Row(
																																																																						 mainAxisAlignment: MainAxisAlignment.spaceBetween,
																																																																				   children: [
																																																																				     Container(
																																																																						 padding: EdgeInsets.only(top:15, bottom:15),
																																																																						 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.red[700], fontSize: 14)),
																																																																				     ),
																																																										 ElevatedButton(onPressed: () async{ 
																																																											 //await viewmodel.setAppointment(referrals[index].id);
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
																																																			child:Text("Reschedule Appointment",style:TextStyle(fontSize: 15, color: Colors.pink),textAlign: TextAlign.left,),
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
																																																			//selectableDayPredicate: (date) {
																																																			//	// Disable weekend days to select from the calendar
																																																			//	if (date.weekday == 6 || date.weekday == 7) {
																																																			//		return false;
																																																			//	}

																																																			//	return true;
																																																			//},
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
																																																								viewmodel.setAppointment(referrals[index].id, viewmodel.appointmentDate);
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
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.white,
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text("Reschedule", style: TextStyle(color: Colors.black38)),
																																																								 )

																																																																				   ],
																																																																				 ),
																																														 if(referrals[index].status=="Completed")
																																															 Row(
																																																	 //mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																	 children: [
																																																		 Container(
																																																				 padding: EdgeInsets.only(top:15, bottom:15),
																																																				 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.green, fontSize: 14)),
																																																		 ),
																																																		 SizedBox(width:5),
																																																		 Icon(Icons.mark_email_unread, color: Colors.green, size: 16),
																																																				 ],
																																																				 ),
																																																				 if(referrals[index].status=="Confirmed")
																																																					 Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Container(
																																																										 padding: EdgeInsets.only(top:15, bottom:15),
																																																										 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.blue, fontSize: 14)),
																																																								 ),
																																																								 PopupMenuButton(
																																																										 icon:Icon(Icons.more_horiz, color: Colors.black),
																																																										 itemBuilder: (context){
																																																											 return [
																																																												 PopupMenuItem(
																																																														 value:0,
																																																														 child: Text('Refer Out', style:TextStyle(color:Colors.black38))),	
																																																												 PopupMenuItem(
																																																														 value:1,
																																																														 child: Text('Referral Reply')),	
																																																											 ];
																																																										 },
																																																										 onSelected:(value){
																																																											 if(value==1){
																																																												 print("name");
																																																												 print(referrals[index].patientName);
																																																												 Navigator.push(context, MaterialPageRoute(builder: (context)=> CompleteCaseView(user: user, referral: referrals[index], isViewing: false )));
																																																											 }
																																																										 }

																																																								 )
																																																										 ],
																																																										 ),

																																																										 ],
																																																										 ),
																																																										 ),
																																																										 );
																									},
																									);
																						}else return Text('no ref for this date');
																					} 
														)
																)
																],
																);
													});
										} else return 
											Center(
													child: 
													CircularProgressIndicator(),
											);
									}),
									);
				}
		);

	}
}
