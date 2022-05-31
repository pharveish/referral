import 'package:flutter/material.dart';
import 'package:referral/ui/addReferral/byFacilty/facility_list_viewmodel.dart';
import 'package:referral/ui/addReferral/referralForm/patientInfo/patientInfo_view.dart';
import 'package:referral/ui/home/home_view.dart';
import 'package:stacked/stacked.dart';

class DoctorByFacilityView extends StatelessWidget {
	static route ({user, doctorList, referral, isDelegate}) => MaterialPageRoute(builder: (context)=> DoctorByFacilityView (user: user, doctorList:doctorList, referral: referral, isDelegate: isDelegate));
	final user, doctorList, referral, isDelegate;
	DoctorByFacilityView  ({this.user, this.doctorList, this.referral, this.isDelegate});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<FacilityListViewModel>.reactive(
				viewModelBuilder: ()=> FacilityListViewModel(), 
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
																	body: Column(
																			children: [
																				Container(
																						height: 50,
																						padding: EdgeInsets.only(top:15, left:20, right:20),
																						child: TextField(
																								onChanged: (value){
																									List results = [];
																									if(value.isEmpty){
																										results = doctorList;
																										viewmodel.filteredList=results;
																										viewmodel.notifyListeners();
																									}else{
																										results = doctorList.where((doctor)=> doctor.name.toLowerCase().contains(value.toLowerCase())).toList();
																										viewmodel.filteredList=results;
																										viewmodel.notifyListeners();
																									}	
																								},
																								decoration: InputDecoration(
																																isDense:true,
																																contentPadding: EdgeInsets.all(5),
																																prefixIcon: Icon(Icons.search),
																																border: OutlineInputBorder(
																																		borderSide: const BorderSide(color: Colors.pink),
																																		borderRadius: BorderRadius.circular(12),
																																),
																																enabledBorder: OutlineInputBorder(
																																		borderSide: const BorderSide(color: Colors.pink),
																																		borderRadius: BorderRadius.circular(12),
																																),
																														),
																								),
																								),
																								Container(
																										height: 55,
																										padding: EdgeInsets.all(10),
																										child: ListView.builder(
																												scrollDirection: Axis.horizontal,
																												itemCount: viewmodel.specialtyList.length,
																												itemBuilder:(BuildContext context, int index){
																													return Container(
																															padding: EdgeInsets.only(left:10),
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
																																		viewmodel.filterSpecialty(viewmodel.specialtyList[index]);
																																	},
																																	child: Text('${viewmodel.specialtyList[index]}', style: TextStyle(color: Colors.pink),),
																															),
																													);
																												}
																										),
					),
					Container(
							alignment: Alignment.centerLeft,
							padding: EdgeInsets.only(left: 20),
							child:viewmodel.filteredList.length==0?Text('${doctorList.length} results(s)', textAlign: TextAlign.left, style: TextStyle(color: Colors.black54)):Text('${viewmodel.filteredList.length} results(s)', textAlign: TextAlign.left, style: TextStyle(color: Colors.black54))
					),
					Expanded(
							child: Container(
									padding: EdgeInsets.only(right:10, left: 10),
									child: viewmodel.filteredList.length==0?ListView.builder(
											itemCount: doctorList.length,
											itemBuilder: (BuildContext context, int index) {
												return Card(
														child: ListTile(
																leading: CircleAvatar(
																		backgroundImage: AssetImage('assets/icons/login.jpg')
																),
																title: Text(doctorList[index].name),
																subtitle: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text('${doctorList[index].credentials}\n${doctorList[index].specialty}', textAlign: TextAlign.left),
																			Row(
																					children: [
																						Icon(Icons.call_outlined, color: Colors.pink,),
																						Icon(Icons.email_outlined, color: Colors.pink),
																					],
																			)
																		],
																),
																trailing: InkWell(
																		onTap: ()async{
																			if(referral==null && isDelegate==false){
																			Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientInfoView(user: user, doctor: doctorList[index])));
																			} else if(isDelegate==false){
																				await viewmodel.reassign(referral.id, doctorList[index].id);
																			Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeView(user: user )));
																			}
																			else if(isDelegate==true){
																				print("delegate function");
																				print(user.id);
																				print(doctorList[index].id);
																				await viewmodel.addToDelegate(user.id, doctorList[index].id);
																				Navigator.pop(context);
																			}
																		},
																		child:Icon(Icons.keyboard_arrow_right),),
																		isThreeLine: true,
																		),
																		);	
											},

											):
												ListView.builder(
														itemCount: viewmodel.filteredList.length,
														itemBuilder: (BuildContext context, int index) {
															return Card(
																	child: ListTile(
																			leading: CircleAvatar(
																					backgroundImage: AssetImage('assets/icons/login.jpg')
																			),
																			title: Text(viewmodel.filteredList[index].name),
																			subtitle: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text('${viewmodel.filteredList[index].credentials}\n${viewmodel.filteredList[index].specialty}', textAlign: TextAlign.left),
																						Row(
																								children: [
																									Icon(Icons.call_outlined, color: Colors.pink,),
																									Icon(Icons.email_outlined, color: Colors.pink),
																								],
																						)
																					],
																			),
																			trailing: InkWell(
																					onTap: ()async{
																			if(referral==null){
																			Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientInfoView(user: user, doctor: viewmodel.filteredList[index])));
																			} else{
																				await viewmodel.reassign(referral.id, viewmodel.filteredList[index].id);
																			Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeView(user: user )));
																			}
																					},
																					child:Icon(Icons.keyboard_arrow_right),),
																					isThreeLine: true,
																					),
																					);	
														},

														)
																,
														),
														),
														],
														)
																);
				});
	}
}
