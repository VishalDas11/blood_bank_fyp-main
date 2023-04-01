// ignore_for_file: camel_case_types

import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../routes/routes_name.dart';

class BottomNav_View extends StatelessWidget {
  const BottomNav_View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.home);
                },
                child: const Image(
                    height: 25,
                    width: 25,
                    color: AppColor.iconColor,
                    image: AssetImage('images/icon/home.png'))),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.donor_list);
                },
                child: const Image(
                    height: 25,
                    width: 25,
                    color: AppColor.iconColor,
                    image: AssetImage('images/icon/reminder.png'))),
            SizedBox(width: MediaQuery.of(context).size.width * 0.8 * 0.1),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.request_list);
                },
                child: const Image(
                    height: 25,
                    width: 25,
                    color: AppColor.iconColor,
                    image: AssetImage('images/icon/bell.png'))),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.profile);
                },
                child: const Image(
                    height: 25,
                    width: 25,
                    color: AppColor.iconColor,
                    image: AssetImage('images/icon/person.png')))
          ]
    );
  }
}
