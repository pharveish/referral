import 'package:flutter/material.dart';
import 'package:referral/model/doctor.dart';
import 'package:referral/ui/addReferral/byDoctor/doctor_view.dart';
import 'package:referral/ui/addReferral/byFacilty/facility_list_view.dart';
import 'package:referral/ui/addReferral/bySpecialty/specialty_list_view.dart';
import 'package:referral/ui/addReferral/category/category_view.dart';
import 'package:referral/ui/home/home_view.dart';
import 'package:referral/ui/login/login_view.dart';
import 'package:referral/ui/splashScereen/splash_view.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case '/':
			return SplashView.route();

    case '/welcome':
      return LoginView.route();

    case '/homeview':
      return HomeView.route(user: settings.arguments as Doctor);

    case '/addReferral':
      return CategoryView.route(user: settings.arguments as Doctor);

    case '/doctorList':
      return DoctorListView.route(user: settings.arguments as Doctor);

    case '/specialtyList':
      return SpecialtyListView.route(user: settings.arguments as Doctor);

    case '/hospitalList':
      return FacilityListView.route(user: settings.arguments as Doctor);

  }
  return null;
}
