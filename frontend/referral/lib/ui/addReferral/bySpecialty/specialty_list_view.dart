import 'package:flutter/material.dart';
import 'package:referral/ui/addReferral/bySpecialty/doctors_byspecialty_view.dart';
import 'package:referral/ui/addReferral/bySpecialty/specialty_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SpecialtyListView extends StatelessWidget {
	static route ({user, referral}) => MaterialPageRoute(builder: (context)=> SpecialtyListView(user: user, referral:referral));
	final user, referral;
	SpecialtyListView({this.user, this.referral});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=> SpecialtyListViewModel(), 
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
																	body: ListView.builder(
																			itemCount: viewmodel.specialtyList.length,
																			itemBuilder: (context, index){
																				return Card(
																				  child: ListTile(
																				  		title: Text(viewmodel.specialtyList[index]),
																				  		trailing: 
																							InkWell(
																									onTap: ()async{
																										 await viewmodel.filterSpecialty(viewmodel.specialtyList[index]);
																										 if(referral==null){
																												Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorBySpecialtyView(user: user, doctorList: viewmodel.doctorList)));
																										 } else{
																												Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorBySpecialtyView(user: user, doctorList: viewmodel.doctorList, referral:referral)));

																										 }

																									},
																							child:Icon(Icons.chevron_right, color: Colors.pink)
																							)
																				  ),
																				);
																			}),
					);
				}
				);
	}
}
