import 'package:flutter/material.dart';
import 'package:referral/ui/addReferral/referralForm/clinicalInfo/clinical_view.dart';
import 'package:referral/ui/addReferral/referralForm/patientInfo/patientInfo_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PatientInfoView extends StatelessWidget {
	static route ({user, doctor}) => MaterialPageRoute(builder: (context)=> PatientInfoView(user: user, doctor: doctor));
	final user, doctor;
	PatientInfoView({this.user, this.doctor});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<PatientInfoViewModel>.reactive(viewModelBuilder: ()=>PatientInfoViewModel(), 
				builder: (context, viewmodel, child){
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
																																	primary: Colors.pink,
																																	onPrimary: Colors.red,
																															),
																															onPressed:(){},
																															child: Text('Patient Info', style: TextStyle(color: Colors.white, fontSize:12),),
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
																									SizedBox(height:30),
																									Text('Identification No.', style: TextStyle(color: Colors.black38), textAlign: TextAlign.start,),
																									SizedBox(height:10),
																									Container(
																											width:200,
																											height:30,
																											child: TextField(
																													onChanged: (value){
																														viewmodel.nric=value;
																														print(viewmodel.nric);
																													},	
																													decoration: InputDecoration(
																																					isDense:true,
																																					contentPadding: EdgeInsets.only(left:10),
																																					suffixIcon: IconButton(icon:Icon(Icons.search), onPressed:(){
																																						viewmodel.getPatientDetails(viewmodel.nric);
																																						print(viewmodel.patient.patientName);
																																					}),
																																					border: OutlineInputBorder(
																																											borderSide: const BorderSide(color: Colors.pink),
																																											borderRadius: BorderRadius.circular(12),
																																									)
																																			),
																											),
																											),
																											SizedBox(height:20),
																											Column(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children:[
																														Text('Patient Name', style: TextStyle(color: Colors.black38)),
																														Text(viewmodel.patient.patientName, style: TextStyle(fontSize:16)),
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
																														  			Text(viewmodel.patient.gender, style: TextStyle(fontSize:16))
																														  		]
																														  ),
																														),
																														//SizedBox(width:80),
																														Expanded(
																														  child: Column(
																														  		crossAxisAlignment: CrossAxisAlignment.start,
																														  		children:[
																														  			Text('Mobile No', style: TextStyle(color: Colors.black38)),
																														  			Text(viewmodel.patient.mobileNo, style: TextStyle(fontSize:16)),
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
																																  			Text(viewmodel.patient.homeNo, style: TextStyle(fontSize:16)),
																																  		]
																																  ),
																																),
																																Expanded(
																																  child: Column(
																																  		crossAxisAlignment: CrossAxisAlignment.start,
																																  		children:[
																																  			Text('Mobile No', style: TextStyle(color: Colors.black38)),
																																  			Text(viewmodel.patient.mobileNo, style: TextStyle(fontSize:16)),
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
																																Text(viewmodel.patient.email, style: TextStyle(fontSize:16)),
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
																													  					Text(viewmodel.patient.address, style: TextStyle(fontSize:16)),
																													  			)
																													  		]
																													  ),
																													),
																													Align(
																															alignment: Alignment.bottomCenter,
																															child: Container(
																																	width: double.infinity,
																																	child: ElevatedButton(
																																			onPressed:(){

																														Navigator.push(context, MaterialPageRoute(builder: (context)=> ClinicalView(user: user, doctor: doctor, patient: viewmodel.patient,)));
																																			},
																																			child: Text('Next')
																																	)
																															)
																													)
																													],
																													)
																															)
																															);
				});
	}			

}
