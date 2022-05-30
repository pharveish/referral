
import 'package:flutter/material.dart';
import 'package:patient/model/patient.dart';
import 'package:patient/ui/home/home_view.dart';
import 'package:patient/ui/login/login_view.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case '/':

    case '/welcome':
      return LoginView.route();

    case '/homeview':
      return HomeView.route(user: settings.arguments as Patient);


  }
  return null;
}
