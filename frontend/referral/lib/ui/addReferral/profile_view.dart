import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
	static route ({user, doctor}) => MaterialPageRoute(builder: (context)=> ProfileView(user: user, doctor:doctor));
	final user, doctor;
	ProfileView({this.user, this.doctor});
	@override
	Widget build(BuildContext context) {
		return Scaffold(
									body: Stack(
											children: [
												Container(
													height: 160,
													child: AppBar(
															iconTheme: IconThemeData(
																	color: Colors.black,
															),
									automaticallyImplyLeading: true,
									backgroundColor: Colors.white,
									toolbarHeight: 70.0,
									title: Text("Doctor Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
									centerTitle: true,
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
									//leading:
									//									InkWell(
									//											onTap: ()=>Navigator.pop(context),
									//											child: Flexible(
									//											  child: Container(
									//														height: 10,
									//											  		padding: EdgeInsets.only( left: 10),
									//											  		child:
									//											  		Row(
									//											  				children: [
									//											  					Icon(Icons.chevron_left, color: Colors.black,),
									//											  					Text('Back', style: TextStyle(color: Colors.black)),
									//											  				],
									//											  		),
									//											  ),
									//											),
									//									),

									

													)
												),
												Padding(
														padding: const EdgeInsets.only(top:100),
														child: Container(
														  		margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
														  child: Column(
																	children: [
																		Container(
																				height: MediaQuery.of(context).size.height*0.2,
																				width: MediaQuery.of(context).size.width,
																				decoration: BoxDecoration(
																						color: Colors.white,
																						border: Border.all(
																								color: Colors.pink,
																						),
																						borderRadius: BorderRadius.all(
																								//color: Colors.pink,
																								Radius.circular(20)
																						)
																				),
																				child: Center(
																				  child: Column(
																					mainAxisAlignment: MainAxisAlignment.center,
																					mainAxisSize: MainAxisSize.max,
																				  		children: [
																				  			Text(doctor.name, style: TextStyle(fontSize: 17)),
																								SizedBox(height:10),
																		Container(
																				//height: MediaQuery.of(context).size.height*0.2,
																				//width: MediaQuery.of(context).size.width,
																				decoration: BoxDecoration(
																						color: Colors.pink,
																						border: Border.all(
																								color: Colors.pink,
																						),
																						borderRadius: BorderRadius.all(
																								//color: Colors.pink,
																								Radius.circular(30)
																						)
																				),
																				child:Padding(
																						padding: EdgeInsets.only(left:20, right:20, top:5, bottom: 5),
																				  			child:Text(doctor.specialty, style:TextStyle(color: Colors.white)),
																				)
																		),
																								SizedBox(height:10),
																				  			Text(doctor.credentials),
																								SizedBox(height:10),
																				  			Text(doctor.hospital),
																				  		],
																				  ),
																				)
																		),
																				SizedBox(height:30),
																				Row(
																						mainAxisAlignment: MainAxisAlignment.spaceBetween,
																						children: [
																							Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										Text("Office Phone No.", style: TextStyle(color: Colors.black38, fontSize: 15)),
																										Text(doctor.officePhone, style: TextStyle(fontSize: 15)),
																									],
																							),
																							Icon(Icons.phone_outlined, color: Colors.pink)
																						],
																				),
																				SizedBox(height:25),
																				Row(
																						mainAxisAlignment: MainAxisAlignment.spaceBetween,
																						children: [
																							Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										Text("Mobile Phone No.", style: TextStyle(color: Colors.black38, fontSize: 15)),
																										Text(doctor.mobilePhone, style: TextStyle(fontSize: 15)),
																									],
																							),
																							Icon(Icons.phone_outlined, color: Colors.pink)
																						],
																				),
																				SizedBox(height:25),
																				Row(
																						mainAxisAlignment: MainAxisAlignment.spaceBetween,
																						children: [
																							Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										Text("Fax No.", style: TextStyle(color: Colors.black38, fontSize: 15)),
																										Text(doctor.fax, style: TextStyle(fontSize: 15)),
																									],
																							),
																							//Icon(Icons.phone_outlined, color: Colors.pink)
																						],
																				),
																				SizedBox(height:50),
																				Row(
																						mainAxisAlignment: MainAxisAlignment.spaceBetween,
																						children: [
																							Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										Text("E-mail", style: TextStyle(color: Colors.black38, fontSize: 15)),
																										Text(doctor.email, style: TextStyle(fontSize: 15)),
																									],
																							),
																							Icon(Icons.email_outlined, color: Colors.pink)
																						],
																				),
																				SizedBox(height:50),
																				Row(
																						mainAxisAlignment: MainAxisAlignment.spaceBetween,
																						children: [
																							Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										Text("Practice Location", style: TextStyle(color: Colors.black38, fontSize: 15)),
																										Text(doctor.hospital, style: TextStyle(fontSize: 15)),
																									],
																							),
																							Icon(Icons.location_on_outlined, color: Colors.pink)
																						],
																				),
																	],
														  ),
														)
														),
												//Positioned(
												//		//top:-50,
												//		bottom: -200,
												//		child: Container(
												//				height: 250,
												//				width: 250,
												//				decoration:BoxDecoration(
												//						color: Colors.white,
												//						
												//				)
												//		)
												//)
											],
									)

			
		);
	}
}
