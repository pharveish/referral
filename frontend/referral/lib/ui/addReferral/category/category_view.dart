import 'package:flutter/material.dart';
import 'package:referral/ui/addReferral/byDoctor/doctor_view.dart';
import 'package:referral/ui/addReferral/byFacilty/facility_list_view.dart';
import 'package:referral/ui/addReferral/bySpecialty/doctors_byspecialty_view.dart';
import 'package:referral/ui/addReferral/bySpecialty/specialty_list_view.dart';
import 'package:referral/ui/addReferral/category/category_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../components/constants.dart';

class CategoryView extends StatelessWidget {
	static route ({user, referral}) => MaterialPageRoute(builder: (context)=> CategoryView(user: user, referral:referral));
	final user,referral;
	CategoryView({this.user, this.referral});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<CategoryViewModel>.nonReactive(
				viewModelBuilder:()=> CategoryViewModel() , 
				builder: (context, viewmodel, child){
					if(referral!=null){
					//	print(referral.name);
						print(referral.id);
						print(referral.patientName);
					}
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
																	body: Center(
																			child: Column(
																					mainAxisAlignment: MainAxisAlignment.center,
																					mainAxisSize: MainAxisSize.max,
																					children: [
																						ConstrainedBox(
																								constraints: const BoxConstraints.tightFor(width: 250, height: 50),
																								child: ElevatedButton(
																										style: ElevatedButton.styleFrom(
																												shape: RoundedRectangleBorder(
																														borderRadius: BorderRadius.circular(30.0),
																												),
																												primary: kPrimaryColor,
																												onPrimary: Colors.pink,
																										),
																										onPressed:(){
																										if(referral==null){
																											Navigator.pushNamed(
																													context, '/hospitalList',
																													arguments: user);
																										} else{
																											Navigator.push(context, MaterialPageRoute(builder: (context)=> FacilityListView(user: user, referral: referral, )));
																										}

																										},
																										child: Text('Facility Centre', style: TextStyle(color: Colors.black),),
																								),
																						),
																						SizedBox(height: 30),
																						ConstrainedBox(
																								constraints: const BoxConstraints.tightFor(width: 250, height: 50),
																								child: ElevatedButton(
																										style: ElevatedButton.styleFrom(
																												shape: RoundedRectangleBorder(
																														borderRadius: BorderRadius.circular(30.0),
																												),
																												primary: kPrimaryColor,
																												onPrimary: Colors.pink,
																										),
																										onPressed:(){
																										if(referral==null){
																											Navigator.pushNamed(
																													context, '/specialtyList',
																													arguments: user);
																										} else{
																											Navigator.push(context, MaterialPageRoute(builder: (context)=> SpecialtyListView(user: user, referral: referral, )));
																										}
																										},
																										child: Text('Specialty', style: TextStyle(color: Colors.black),),
																								),
																						),
																						SizedBox(height: 30),
																						ConstrainedBox(
																								constraints: const BoxConstraints.tightFor(width: 250, height: 50),
																								child: ElevatedButton(
																										style: ElevatedButton.styleFrom(
																												shape: RoundedRectangleBorder(
																														borderRadius: BorderRadius.circular(30.0),
																												),
																												shadowColor: Colors.black,
																												primary: kPrimaryColor,
																												onPrimary: Colors.pink,
																										),
																										onPressed:(){
																										if(referral==null){
																											Navigator.pushNamed(
																													context, '/doctorList',
																													arguments: user);
																										} else {
																											Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorListView(user: user, referral: referral, )));

																										}

																										},
																										child: Text('Doctor', style: TextStyle(color: Colors.black),),
																								),
																						),
																						],
																						),
																						),
																						);		
				});
	}
}
