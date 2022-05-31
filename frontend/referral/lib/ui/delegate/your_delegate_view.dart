import 'package:flutter/material.dart';
import 'package:referral/ui/addReferral/byFacilty/doctors_byfacility_view.dart';
import 'package:stacked/stacked.dart';

import 'your_delegate_viewmodel.dart';

class YourDelegateView extends StatelessWidget {
	static route ({user, referral}) => MaterialPageRoute(builder: (context)=> YourDelegateView(user: user, referral:referral));
	final user,referral;
	YourDelegateView({this.user, this.referral});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=> YourDelegateViewModel(), builder: (context, viewmodel, child){
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
																				Text('Your Delegates', style: TextStyle(color: Colors.pink),),
																		),
																	],
																	)
																			),
																	),
																	)

																			),
																	body: Container(
																			padding: EdgeInsets.all(15),
																	  child: FutureBuilder(
																	  		future: viewmodel.getDelegatesByDoctorId(user.id),
																	  		builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
																	  			if(snapshot.hasData){
																						viewmodel.notifyListeners();
																	  						List delegates = snapshot.data;
																	  				return ListView.builder(
																	  					itemCount: delegates.length,
																	  					itemBuilder: (BuildContext context, int index){
																	  						return Card(
																	  								child: ListTile(
																	  										title: Text(snapshot.data[index].delegateToName),
																	  										subtitle: Text(snapshot.data[index].delegateToSpecialty),
																												trailing: ElevatedButton(
																															style: ElevatedButton.styleFrom(
																																	shape: RoundedRectangleBorder(
																																			borderRadius: BorderRadius.circular(10.0),
																																			side: BorderSide(color: Colors.pink)
																																	),
																																	primary: Colors.white,
																																	onPrimary: Colors.red,
																															),
																															onPressed:(){
																																//Navigator.push(context, MaterialPageRoute(builder: (context)=> ClinicalView(user: user, referral: referral)));
																															},
																															child: Text('Delegate Referral', style: TextStyle(color: Colors.pink, fontSize: 12),),
																													)
																	  								)
																	  						);
																	  					});}
																	  			else return CircularProgressIndicator();
																	  		}
																	  		),
																	),
																	floatingActionButton: FloatingActionButton(
																				onPressed: ()async{
																					await viewmodel.filterHospital(user.hospital);
																					Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorByFacilityView(user: user, doctorList: viewmodel.doctorList, referral:referral, isDelegate: true))).then((value){viewmodel.notifyListeners();});
																				},
																				child: Icon(Icons.add),
																		)

			);
		});
	}
}
