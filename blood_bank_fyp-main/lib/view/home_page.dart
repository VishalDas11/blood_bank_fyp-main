// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../components/bottom_nav.dart';
import '../components/button_view.dart';
import '../components/drawer.dart';
import '../routes/routes_name.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int activeindex = 0;
  final imageUrl = [
    'https://img.freepik.com/premium-psd/donate-blood-banner-template_23-2148690140.jpg?w=740',
    'https://img.freepik.com/free-psd/donate-blood-campaign-banner-template_23-2148690135.jpg?w=740&t=st=1667714809~exp=1667715409~hmac=d65e022b351c1d7c138aa134f1363695314efeeed4854ef9a074ee02b39f63d2',
    'https://img.freepik.com/free-psd/donate-blood-campaign-horizontal-banner_23-2148690136.jpg?w=740&t=st=1667714724~exp=1667715324~hmac=7edcfd52452c99d2eefbdab9eaa309d8c42cb534b5858578c866a2506df43d11',
    'https://img.freepik.com/free-psd/donate-blood-campaign-banner_23-2148690137.jpg?w=740&t=st=1667715864~exp=1667716464~hmac=0d6a29061914e63b9b2daa5c000a805f9c125fbd03d5697492033769c28900a1',
  ];
  @override
  Widget build(BuildContext context) {
    final mheight = MediaQuery.of(context).size.height * 0.8;
    final mwidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
        drawer: Drawer_View(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => TextButton(
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black26),
                    image:
                        DecorationImage(image: AssetImage('images/user.png'))),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          key: _scaffoldKey,
        ),
        backgroundColor: AppColor.bgColor,
        body:SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: mheight * 0.01),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            CarouselSlider.builder(
                                itemCount: imageUrl.length,
                                itemBuilder: (context, index,realIndex){
                                  final imageUrls = imageUrl[index];
                                  return buildImage(imageUrls, index);
                                },
                                options: CarouselOptions(
                                  // height: MediaQuery.of(context).size.height *1/4,
                                    autoPlay: true,
                                    autoPlayAnimationDuration: Duration(seconds: 2),
                                    viewportFraction: 1,
                                    // enlargeCenterPage: true,
                                    onPageChanged: (index, reason){
                                      setState(()=> activeindex = index);
                                    }
                                )),
                        SizedBox(height: 10,),
                        buildIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(height: mheight * 0.03),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Button_view(
                                img: 'images/icon/order.png',
                                title: 'Add Request',
                                onpress: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.addrequest_form);
                                },
                                topl: 10,
                                topr: 30,
                                bottoml: 30,
                                bottomr: 10,
                              ),
                              SizedBox(width: mwidth * 0.06),
                              Button_view(
                                img: 'images/icon/donate.png',
                                title: 'Donate form',
                                onpress: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.donate_form);
                                },
                                topl: 30,
                                topr: 10,
                                bottoml: 10,
                                bottomr: 30,
                              ),
                            ],
                          ),
                          SizedBox(height: mheight * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Button_view(
                                img: 'images/icon/donator.png',
                                title: 'Request List',
                                onpress: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.request_list);
                                },
                                topl: 30,
                                topr: 10,
                                bottoml: 10,
                                bottomr: 30,
                              ),
                              SizedBox(width: mwidth * 0.06),
                              Button_view(
                                img: 'images/icon/donor.png',
                                title: 'Donor List',
                                onpress: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.donor_list);
                                },
                                topl: 10,
                                topr: 30,
                                bottoml: 30,
                                bottomr: 10,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: mheight * 0.01),
                    ],
                  ),
                ))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.donate_form);
          },
          backgroundColor: Colors.redAccent,
          child: Image(
            image: AssetImage('images/icon/blood-drop.png'),
            color: AppColor.whiteColor,
            height: 25,
            width: 25,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: BottomNav_View(),
        ));
  }

  Widget buildImage(String imageUrls, int index  ){
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(imageUrls, fit: BoxFit.cover,)),
    );
  }
  Widget buildIndicator()=> AnimatedSmoothIndicator(
      activeIndex: activeindex,
      count: imageUrl.length
  );
}

