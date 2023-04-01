// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:io';
import 'package:blood_bank_fyp/routes/routes_name.dart';
import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:blood_bank_fyp/utils/toastMassage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key}) : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  // final auth = FirebaseAuth.instance;
  // User? user = FirebaseAuth.instance.currentUser;
  // CollectionReference userCollection = FirebaseFirestore.instance.collection('Data');

  // final fetch = FirebaseFirestore.instance.collection('Data').doc(user).get();
  // String group = '';
  //Firease Connectivity
  //  _getUser() async {
  //   final auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //   _uid = user!.uid;
  //   // final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Data').doc(_uid).get();
  //   FirebaseFirestore.instance.collection('Data').doc(_uid).get().then((userDoc) {
  //     setState(() {
  //       username = userDoc.get('name');
  //       email = userDoc.get('email');
  //       phone = userDoc.get('mobile');
  //       add = userDoc.get('city');
  //       // group = userDoc.get('blood Group');
  //     });
  // });
  //  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getUser();
  // }

  final _name = TextEditingController();
  final _number = TextEditingController();
  final _city = TextEditingController();
  final _firesotre =  FirebaseFirestore.instance.collection("Data");
  File? _image;
  final picker  = ImagePicker();
  Future _getimageGallery()async{
    final pickfiled = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if(pickfiled!=null){
        _image = File(pickfiled.path);
      }else{
        Utils().ToastMassage('No image Picked');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          title: Text(
            'Profile',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: AppColor.btxtColor, fontWeight: FontWeight.w600),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.greColor,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Data")
                          .where("email",
                              isEqualTo:
                                  FirebaseAuth.instance.currentUser!.email)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                var data = snapshot.data!.docs[i];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Stack(children: [
                                        InkWell(
                                          onTap: (){
                                            _getimageGallery();
                                          },
                                          child:  Container(
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: Color.fromARGB(
                                                      255, 231, 228, 228)),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10))
                                              ]),
                                            child: _image!=null?CircleAvatar(backgroundImage:FileImage(_image!.absolute),):CircleAvatar(backgroundImage: AssetImage( 'images/user.png'),),
                                        ),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              child: Center(child: Text(data['blood Group'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: AppColor.whiteColor),),),
                                              // color: Colors.green,
                                              decoration: BoxDecoration(
                                                  color: AppColor.draColor,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Color.fromARGB(
                                                          255, 231, 228, 228))),
                                            ))
                                      ]),
                                    ),
                                    SizedBox(height: 20),
                                    Text(data['name'],
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(data['city'],
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600))),
                                    SizedBox(height: 25),
                                    Align(alignment: Alignment.centerLeft,child:Text('Full Name',style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54
                                        )),),),
                                    Padding(padding: EdgeInsets.only(top: 5,bottom: 15),child:
                                    Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1.0, color: Colors.black38))
                                        ),
                                        child: Text(data['name'],style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black26),
                                        )))),
                                    // buildTextField('Full Name', data['name'],_name),
                                    Align(alignment: Alignment.centerLeft,child:Text('E-Mail',style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54
                                        )),),),
                                    Padding(padding: EdgeInsets.only(top: 5,bottom: 15),child:
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1.0, color: Colors.black38))
                                      ),
                                      child: Text(data['email'],style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black26),
                                    )))),
                                    buildTextField('Number', data['mobile'],_number),
                                    buildTextField('Address', data['city'],_city),
                                    SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // ignore: deprecated_member_use
                                        InkWell(
                                          onTap: (){
                                            final auth = FirebaseAuth.instance;
                                            auth.signOut().then((value) {
                                              Navigator.pushNamed(context, RoutesName.login);
                                            }).onError((error, stackTrace) {
                                              Utils().ToastMassage(error.toString());
                                            });},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColor.draColor),
                                            height: 40,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                'Sign Out',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            _firesotre.doc(data['id'].toString()).update({
                                              'name': _name.text.toString(),
                                              'mobile' : _number.text.toString(),
                                              'city' : _city.text.toString()
                                            }).then((value) {
                                              Utils().ToastMassage('Update Data');
                                            }).onError((error, stackTrace){
                                              Utils().ToastMassage(error.toString());
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blue),
                                            height: 40,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                'Save',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              });
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }
                      }))),
        ));
  }

  Widget buildTextField(String label, String hinttext,var controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 4),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: label,
            labelStyle: GoogleFonts.openSans(
                textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            hintText: hinttext,
            hintStyle: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26))),
      ),
    );
  }
}
