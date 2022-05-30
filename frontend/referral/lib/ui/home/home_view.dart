import 'package:flutter/material.dart';
import 'package:referral/ui/home/tabviews/referredin/referredin_view.dart';
import 'package:referral/ui/home/tabviews/referredout/referredout_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
	static route ({user}) => MaterialPageRoute(builder: (context)=> HomeView(user: user));
	final user;
	HomeView({this.user});
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<HomeViewModel>.reactive(
				builder: (context, viewmodel, child) =>
				DefaultTabController(
						length:2,
						child: Scaffold(
							appBar: AppBar(
									automaticallyImplyLeading: false,
									backgroundColor: Colors.white,
									toolbarHeight: 80.0,
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
																await viewmodel.removeToken(user.id);
																Navigator.pushNamedAndRemoveUntil(
																		context, '/', ModalRoute.withName('/'),
																		);
																}
													}
												
												)
									],
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
												child: ColoredBox(
														color: Colors.white,
														child: TabBar(
																labelColor: Colors.pink,
																unselectedLabelColor: Colors.black,
																tabs: [
																	Tab(text: 'Referred In'),
																	Tab(text: 'Referred Out')
																]
														),
												),
										)

												),
										body: TabBarView(children: [
											ReferredInView(user:user),
											ReferredOutView(user: user),
										]),						
												),
										), 
										viewModelBuilder: () => HomeViewModel(),

										);

	}
}
