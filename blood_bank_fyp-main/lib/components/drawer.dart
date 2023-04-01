// ignore_for_file: camel_case_types
import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:blood_bank_fyp/utils/toastMassage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/routes_name.dart';

class Drawer_View extends StatefulWidget {
  const Drawer_View({Key? key}) : super(key: key);

  @override
  State<Drawer_View> createState() => _Drawer_ViewState();
}

class _Drawer_ViewState extends State<Drawer_View> {
String? Email;

  // void _getdata()async{
  //   final auth = FirebaseAuth.instance.currentUser;
  //   if(auth!=null)
  //     await FirebaseFirestore.instance.collection('Data').doc(auth.uid).get().then((data){
  //       Email = data.data['email'];
  //     }).onError((error, stackTrace){
  //       Utils().ToastMassage(error.toString());
  //       print(error.toString());
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppColor.bgColor,
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: AppColor.draColor,
                ),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Data')
                        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              return UserAccountsDrawerHeader(
                                  decoration: const BoxDecoration(
                                      color: AppColor.draColor),
                                  accountName: Text(
                                    data['name'],
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  accountEmail: Text(data['email'],
                                      style: GoogleFonts.openSans(
                                          textStyle:
                                              const TextStyle(fontSize: 15))),
                                  currentAccountPicture: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RoutesName.profile);
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('images/user.png'),
                                    ),
                                  ));
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
            Build_List(
              title: 'Home',
              icon: 'images/icon/home.png',
              ontap: () {
                Navigator.pushNamed(context, RoutesName.home);
              },
            ),
            Build_List(
              title: 'Donate form',
              icon: 'images/icon/blood-drop.png',
              ontap: () {
                Navigator.pushNamed(context, RoutesName.donate_form);
              },
            ),
            Build_List(
              title: 'Add Request form',
              icon: 'images/icon/add_request.png',
              ontap: () {
                Navigator.pushNamed(context, RoutesName.addrequest_form);
              },
            ),
            Build_List(
              title: 'Request list',
              icon: 'images/icon/request.png',
              ontap: () {
                Navigator.pushNamed(context, RoutesName.request_list);
              },
            ),
            Build_List(
              title: 'Donor List',
              icon: 'images/icon/reminder.png',
              ontap: () {
                Navigator.pushNamed(context, RoutesName.donor_list);
              },
            ),
            Build_List(
              title: 'Log Out',
              icon: 'images/icon/logout.png',
              ontap: () {
                final auth = FirebaseAuth.instance;
                auth.signOut().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                }).onError((error, stackTrace) {
                  Utils().ToastMassage(error.toString());
                });
              },
            ),
          ],
        ));
  }
}

class Build_List extends StatelessWidget {
  final String title;
  final dynamic icon;
  final VoidCallback ontap;

  const Build_List(
      {Key? key, required this.title, required this.ontap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.asset(
          icon,
          height: 25,
          width: 25,
          color: AppColor.iconColor,
        ),
        title: Text(
          title,
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(color: AppColor.iconColor)),
        ),
        selected: true,
        onTap: ontap);
  }
}
