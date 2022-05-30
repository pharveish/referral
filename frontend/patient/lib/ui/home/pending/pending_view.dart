
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/ui/components/constants.dart';
import 'package:patient/ui/home/pending/pending_viewmodel.dart';
import 'package:patient/ui/referralDetails/referral_details_view.dart';
import 'package:stacked/stacked.dart';

class PendingView extends StatelessWidget {
	static route ({user, status}) => MaterialPageRoute(builder: (context)=> PendingView(user: user, status:status));
	final user, status;
	PendingView({this.user, this.status});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<PendingViewModel>.reactive(viewModelBuilder: ()=> PendingViewModel(), builder: (context, viewmodel, child) {
			var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
		  return Container(
							height: MediaQuery.of(context).size.height,
							padding: EdgeInsets.all(10),
							color: kBackgroundColor,
							child: FutureBuilder(
									future: viewmodel.listDates(user.id, status),
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
																					future: viewmodel.getReferralsByDate(user.id, formattedDate, status),
																					builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
																						if(snapshot.hasData){
																							List referrals = snapshot.data;
																							return ListView.builder(
																									physics: NeverScrollableScrollPhysics(),
																									shrinkWrap:true,
																									itemCount: referrals.length,
																									itemBuilder: (BuildContext context, int index){
																										return InkWell(
																												onTap:()async{
																													await viewmodel.getReferralById(referrals[index].id);
																													await viewmodel.getDocuments(referrals[index].id);
																													Navigator.push(context, MaterialPageRoute(builder: (context)=> ReferralDetailsView(user: user, referral: viewmodel.referral, documents: viewmodel.documents )));

																												},
																												child: Container(
																																	 padding: EdgeInsets.all(10),
																																	 margin: EdgeInsets.only(bottom:15),
																																	 decoration: BoxDecoration(
																																			 boxShadow: [
																																				 BoxShadow( color: Colors.grey[600],
																																						 //blurRadius: 2.0,
																																						 //spreadRadius: 0.0,
																																						 //offset: Offset(0.0, 3.0),
																																						 )
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
																																												 Text('Doctor', textAlign: TextAlign.left, 
																																														 style: TextStyle(
																																																 color: Colors.black38
																																														 )),
																																												//if(referrals[index].followUp==true){
																																												 Text(referrals[index].doctorToName, textAlign: TextAlign.left),
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
																																																				 if(referrals[index].status=="Appointment Denied")
																																																					 Container(
																																																							 margin: EdgeInsets.only(top:10),
																																																					   child: Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Container(
																																																										 child: Row(
																																																												 //crossAxisAlignment: CrossAxisAlignment.start,
																																																												 children: [
																																																													 RawMaterialButton(

																																																															 constraints: BoxConstraints(minWidth:0 ),
																																																															 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
																																																															 onPressed: (){},
																																																															 fillColor: Colors.white,
																																																															 shape: CircleBorder(),
																																																															 padding: EdgeInsets.all(8.0),
																																																															 elevation:2,
																																																													 child:Icon(Icons.calendar_today_outlined, size: 17, color: Colors.black54),

																																																															 ),
																																																													 SizedBox(width:10),
																																																													 Column(
																																																												 crossAxisAlignment: CrossAxisAlignment.start,
																																																															 children: [
																																																																 Text(outputFormat.format(referrals[index].appointmentDate)),
																																																																 Text("Appointment Date", style:TextStyle(color: Colors.black38)),
																																																															 ],
																																																													 )
																																																												 ],
																																																										 )
																																																								 ),
																																																										 ElevatedButton(onPressed: () { 
																																																										 },
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.red,
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text("Appointment Denied", style: TextStyle(color: Colors.red)),
																																																								 )
																																																										 ],
																																																										 ),
																																																					 ),
																																																				 if(referrals[index].status=="Confirmed")
																																																					 Container(
																																																							 margin: EdgeInsets.only(top:10),
																																																					   child: Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Container(
																																																										 child: Row(
																																																												 //crossAxisAlignment: CrossAxisAlignment.start,
																																																												 children: [
																																																													 RawMaterialButton(

																																																															 constraints: BoxConstraints(minWidth:0 ),
																																																															 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
																																																															 onPressed: (){},
																																																															 fillColor: Colors.white,
																																																															 shape: CircleBorder(),
																																																															 padding: EdgeInsets.all(8.0),
																																																															 elevation:2,
																																																													 child:Icon(Icons.calendar_today_outlined, size: 17, color: Colors.black54),

																																																															 ),
																																																													 SizedBox(width:10),
																																																													 Column(
																																																												 crossAxisAlignment: CrossAxisAlignment.start,
																																																															 children: [
																																																																 Text(outputFormat.format(referrals[index].appointmentDate)),
																																																																 Text("Appointment Date", style:TextStyle(color: Colors.black38)),
																																																															 ],
																																																													 )
																																																												 ],
																																																										 )
																																																								 ),
																																																										 ElevatedButton(onPressed: () async{ 
																																																											 await viewmodel.denyAppointment(referrals[index].id);
																																																										 },
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.white,
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text("Deny", style: TextStyle(color: Colors.black38)),
																																																								 )
																																																										 ],
																																																										 ),
																																																					 ),

																																																										 ],
																																																										 ),
																																																										 ),
																																																										 );
																									},
																									);
																						}else return CircularProgressIndicator();
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
		});
	}
}
