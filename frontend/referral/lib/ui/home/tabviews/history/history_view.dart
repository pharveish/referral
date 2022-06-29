import 'dart:math';

import 'package:flutter/material.dart';
import 'package:referral/ui/addReferral/category/category_view.dart';
import 'package:referral/ui/completeCase/complete_view.dart';
import 'package:referral/ui/home/tabviews/history/history_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HistoryView extends StatelessWidget {
	static route ({user}) => MaterialPageRoute(builder: (context)=> HistoryView(user: user));
	final user;
	HistoryView({this.user});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<HistoryViewModel>.reactive(viewModelBuilder: ()=>HistoryViewModel(), 
				builder: (context, viewmodel, child){
					return Container(
							color: Colors.grey[200],
							child: Column(
									children:
									[
										Container(
												height: MediaQuery.of(context).size.height * 0.67,
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
																								padding: EdgeInsets.all(10),
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
																																	onTap: (){
																																		if(referrals[index].status=="Completed")Navigator.push(context, MaterialPageRoute(builder: (context)=> CompleteCaseView(user: user, referral: referrals[index], isViewing:true )));

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
																																								 color: referrals[index].doctorToId==user.id?Colors.white:Colors.pink[50],
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
																																																					 SizedBox(height:5),

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
																																																										 ),
																																																										 Align(
																																																												 alignment: Alignment.bottomRight,
																																																												 child: Row(
																																																														 mainAxisAlignment: MainAxisAlignment.end,
																																																														 children: [
																																																															 ElevatedButton(
																																																																	 style: ElevatedButton.styleFrom(

																																																																			 shape: RoundedRectangleBorder(
																																																																					 borderRadius: BorderRadius.circular(10.0),
																																																																					 side: BorderSide(color: Colors.pink)
																																																																			 ),
																																																																			 primary: Colors.white,
																																																																			 onPrimary: Colors.red,
																																																																	 ),
																																																																	 onPressed:()async{
																																																																		 await viewmodel.abort(referrals[index].id);
																																																																		 //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeView(user: user)));
																																																																	 },
																																																																	 child: Text('Abort', style: TextStyle(color:Colors.red))
																																																															 ),
																																																															 SizedBox(width:5),
																																																															 ElevatedButton(
																																																																	 style: ElevatedButton.styleFrom(

																																																																			 shape: RoundedRectangleBorder(
																																																																					 borderRadius: BorderRadius.circular(10.0),
																																																																					 side: BorderSide(color: Colors.pink)
																																																																			 ),
																																																																			 primary: Colors.pink,
																																																																			 onPrimary: Colors.red,
																																																																	 ),
																																																																	 onPressed:()async{
																																																																		await viewmodel.getReferralById(referrals[index].id);
																																																																	Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryView(user: user, referral: viewmodel.referral, )));
																																																																	 },
																																																																	 child: Text('Reassign', style: TextStyle(color:Colors.white))
																																																															 ),
																																																														 ]
																																																												 )

																																																												 ),

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
																																																																			 if(referrals[index].status=="Pending")
																																																																				 Container(
																																																																						 padding: EdgeInsets.only(top:15, bottom:15),
																																																																						 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.yellow[700], fontSize: 14)),
																																																																				 ),
																																																																			 if(referrals[index].status=="Appointment Denied")
																																																																				 Container(
																																																																						 padding: EdgeInsets.only(top:15, bottom:15),
																																																																						 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.red[700], fontSize: 14)),
																																																																				 ),
																																																																			 if(referrals[index].status=="Aborted")
																																																																				 Container(
																																																																						 padding: EdgeInsets.only(top:15, bottom:15),
																																																																						 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.red[700], fontSize: 14)),
																																																																				 ),
																																																																					 if(referrals[index].status=="Confirmed")
																																																																						 Row(
																																																																								 mainAxisAlignment:MainAxisAlignment.spaceBetween,
																																																																								 children: [
																																																																									 Container(
																																																																											 padding: EdgeInsets.only(top:15, bottom:15),
																																																																											 child:Text(referrals[index].status, textAlign: TextAlign.left, style: TextStyle(color: Colors.blue, fontSize: 14)),
																																																																									 ),
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
														),
														Container(
																color: Colors.grey[200],
																padding: EdgeInsets.all(20),
																child: Align(
																		alignment: Alignment.centerRight,
																		child:FloatingActionButton(
																				onPressed: (){
																					Navigator.pushNamed(
																							context, '/addReferral',
																							arguments: user );
																				},
																				child: Icon(Icons.add),
																		)
																),
														)
																]
																),
														);
				}
		);

	}
}
