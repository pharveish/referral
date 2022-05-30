import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/ui/components/constants.dart';
import 'package:patient/ui/home/history/history_viewmodel.dart';
import 'package:patient/ui/referralDetails/referral_details_view.dart';
import 'package:stacked/stacked.dart';

class HistoryView extends StatelessWidget {
	static route ({user, status}) => MaterialPageRoute(builder: (context)=> HistoryView(user: user));
	final user; 
	HistoryView({this.user});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=>HistoryViewModel(), 
				builder: (context, viewmodel, child){
			var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
		  return Container(
							height: MediaQuery.of(context).size.height,
							padding: EdgeInsets.all(10),
							color: kBackgroundColor,
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
																					future: viewmodel.getReferralsByDate(user.id, formattedDate ),
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
																																												 Text("Doctor", textAlign: TextAlign.left),
																																												//}
																																												 SizedBox(height:5),
																																												 //Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.white)),

																																												 ],
																																												 ),
																																												 ),	
																																												 ]
																																														 ),
																																																				 if(referrals[index].status=="Confirmed")
																																																					 Container(
																																																							 margin: EdgeInsets.only(top:10),
																																																					   child: Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Text('Status', style: TextStyle(color: Colors.black38)),
																																																								 ElevatedButton(onPressed: () {  },
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 //side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.grey[100],
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text(referrals[index].status, style: TextStyle(color: Colors.blue)),
																																																								 )
																																																										 ],
																																																										 ),
																																																					 ),
																																																				 if(referrals[index].status=="Appointment Denied")
																																																					 Container(
																																																							 margin: EdgeInsets.only(top:10),
																																																					   child: Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Text('Status', style: TextStyle(color: Colors.black38)),
																																																								 ElevatedButton(onPressed: () {  },
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 //side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.grey[100],
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text(referrals[index].status, style: TextStyle(color: Colors.red)),
																																																								 )
																																																										 ],
																																																										 ),
																																																					 ),
																																																				 if(referrals[index].status=="Rejected")
																																																					 Container(
																																																							 margin: EdgeInsets.only(top:10),
																																																					   child: Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Text('Status', style: TextStyle(color: Colors.black38)),
																																																								 ElevatedButton(onPressed: () {  },
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 //side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.grey[100],
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text(referrals[index].status, style: TextStyle(color: Colors.red)),
																																																								 )
																																																										 ],
																																																										 ),
																																																					 ),
																																																				 if(referrals[index].status=="Aborted")
																																																					 Container(
																																																							 margin: EdgeInsets.only(top:10),
																																																					   child: Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Text('Status', style: TextStyle(color: Colors.black38)),
																																																								 ElevatedButton(onPressed: () {  },
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 //side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.grey[100],
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text(referrals[index].status, style: TextStyle(color: Colors.red)),
																																																								 )
																																																										 ],
																																																										 ),
																																																					 ),
																																																				 if(referrals[index].status=="Pending")
																																																					 Container(
																																																							 margin: EdgeInsets.only(top:10),
																																																					   child: Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Text('Status', style: TextStyle(color: Colors.black38)),
																																																								 ElevatedButton(onPressed: () {  },
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 //side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.grey[100],
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text(referrals[index].status, style: TextStyle(color: Colors.yellow[800])),
																																																								 )
																																																										 ],
																																																										 ),
																																																					 ),
																																																				 if(referrals[index].status=="Completed")
																																																					 Container(
																																																							 margin: EdgeInsets.only(top:10),
																																																					   child: Row(
																																																							 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																							 children: [
																																																								 Text('Status', style: TextStyle(color: Colors.black38)),
																																																								 ElevatedButton(onPressed: () {  },
																																																										 style: ElevatedButton.styleFrom(
																																																												 shape: RoundedRectangleBorder(
																																																														 borderRadius: BorderRadius.circular(15.0),
																																																														 //side: BorderSide(color: Colors.black38),
																																																												 ),
																																																												 primary: Colors.grey[100],
																																																												 onPrimary: Colors.black,
																																																										 ),
																																																								 child: Text(referrals[index].status, style: TextStyle(color: Colors.green)),
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
