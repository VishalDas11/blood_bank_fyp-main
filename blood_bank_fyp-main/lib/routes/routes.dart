// ignore_for_file: prefer_const_constructors
import 'package:blood_bank_fyp/routes/routes_name.dart';
import 'package:blood_bank_fyp/view/home_page.dart';
import 'package:blood_bank_fyp/view/add_request_form.dart';
import 'package:blood_bank_fyp/view/donor_list.dart';
import 'package:blood_bank_fyp/view/donate_form.dart';
import 'package:blood_bank_fyp/view/login_page.dart';
import 'package:blood_bank_fyp/view/profile_page.dart';
import 'package:blood_bank_fyp/view/register_form.dart';
import 'package:blood_bank_fyp/view/request_list.dart';
import 'package:blood_bank_fyp/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => Login_Page());
      case RoutesName.register:
        return MaterialPageRoute(builder: (context) => Register_Form());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => Home_Page());
      case RoutesName.request_list:
        return MaterialPageRoute(builder: (context) => Request_List());
      case RoutesName.addrequest_form:
        return MaterialPageRoute(builder: (context) => Add_Blood_Request());
      case RoutesName.profile:
        return MaterialPageRoute(builder: (context) => Profile_Page());
      case RoutesName.donor_list:
        return MaterialPageRoute(builder: (context) => Donor_List());
      case RoutesName.donate_form:
        return MaterialPageRoute(builder: (context) => Donate_Form());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.black,),
            ),
          );
        });
    }
  }
}
