import 'package:flutter/material.dart';
import 'package:patient/ui/components/constants.dart';
import 'package:patient/ui/home/history/history_view.dart';
import 'package:patient/ui/home/home_viewmodel.dart';
import 'package:patient/ui/home/pending/pending_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
	static route ({user}) => MaterialPageRoute(builder: (context)=> HomeView(user: user));
	final user;
	HomeView({this.user});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(viewModelBuilder: ()=> HomeViewModel(), builder: (context, viewmodel, child){
			return DefaultTabController(
					length:3,
					child: Scaffold(
							appBar: AppBar(
									elevation: 0,
									backgroundColor: kBackgroundColor,
									automaticallyImplyLeading: false,
									toolbarHeight: 100.0,
									title: const Text("     Referrals", style: TextStyle(color: Colors.black)),
									actions:[
										PopupMenuButton(
												icon:Icon(Icons.more_vert, color: Colors.black),
												itemBuilder: (context){
													return [
														PopupMenuItem(
																value:0,
																child: Text('Logout'))	
													];
												},
												onSelected:(value)async{
													if(value==0){
														SharedPreferences preferences = await SharedPreferences.getInstance();
														await preferences.clear();
																//await viewmodel.removeToken(user.id);
																Navigator.pushNamedAndRemoveUntil(
																		context, '/', ModalRoute.withName('/'),
																		);
																}
													}
												
												)
									],
									bottom: PreferredSize(
											preferredSize: Size.fromHeight(50),
											child: Container(
													margin: EdgeInsets.only(left:15, right:15),
													padding: EdgeInsets.all(5),
													decoration: BoxDecoration(
															color: Colors.white,
															border: Border.all(color: Colors.white),

															borderRadius: BorderRadius.circular(50),
													),
													child: TabBar(
															unselectedLabelColor: Colors.black38,
															indicatorSize: TabBarIndicatorSize.label,
															indicator: BoxDecoration(
																	borderRadius: BorderRadius.circular(50),
																	color: kPrimaryColor,
															),
															tabs: [
																Tab(
																		child: Container(
																				//decoration: BoxDecoration(
																				//		borderRadius: BorderRadius.circular(50),
																				//		border: Border.all(
																				//				//color: Colors.white,
																				//				width: 1,
																				//		)
																				//),
																				child: Align(
																						alignment: Alignment.center,
																						child:
																						Text("Pending"),
																				)
																		)),
																Tab(
																		child: Container(
																				//decoration: BoxDecoration(
																				//		borderRadius: BorderRadius.circular(50),
																				//		border: Border.all(
																				//				//color: Colors.white,
																				//				width: 1,
																				//		)
																				//),
																				child: Align(
																						alignment: Alignment.center,
																						child:
																						Text("Confirmed"),
																				)
																		)),
																Tab(
																		child: Container(
																				//decoration: BoxDecoration(
																				//		borderRadius: BorderRadius.circular(50),
																				//		border: Border.all(
																				//				//color: Colors.white,
																				//				width: 1,
																				//		)
																				//),
																				child: Align(
																						alignment: Alignment.center,
																						child:
																						Text("History"),
																				)
																		)),
																],
																),
																),
																)
																		),

																body: TabBarView(children: [
																	PendingView(user:user, status: "Pending"),
																	PendingView(user:user, status: "Confirmed"),
																	HistoryView(user:user),
																])

																		),
																);
		});
	}
}
