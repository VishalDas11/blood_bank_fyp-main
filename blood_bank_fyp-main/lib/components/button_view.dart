// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_color.dart';

class Button_view extends StatelessWidget {
  final String img;
  final String title;
  final VoidCallback onpress;
  final double topr;
  final double topl;
  final double bottomr;
  final double bottoml;
 const Button_view({Key? key,
    required this.img,
    required this.title,
    required this.onpress,
    required this.topl,
    required this.topr,
    required this.bottoml,
    required this.bottomr
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  InkWell(
        onTap:onpress,
        child:  Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topl.toDouble()),
            topRight:Radius.circular(topr.toDouble()),
            bottomLeft: Radius.circular(bottoml.toDouble()),
            bottomRight: Radius.circular(bottomr.toDouble())),
        color: AppColor.cardColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child:  Image.asset(img,
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),),
          Text(title,style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.lgreyColor),))
        ],
      ),
    ));
  }
}
