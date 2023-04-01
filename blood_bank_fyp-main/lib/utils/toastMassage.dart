// ignore_for_file: non_constant_identifier_names, file_names
import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  ToastMassage(String massage){
    return Fluttertoast.showToast(
      msg: massage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColor.iconColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}