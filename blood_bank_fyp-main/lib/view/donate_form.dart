// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_import, camel_case_types, prefer_const_constructors

import 'package:blood_bank_fyp/components/custombutton.dart';
import 'package:blood_bank_fyp/routes/routes_name.dart';
import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:blood_bank_fyp/utils/toastMassage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:quickalert/quickalert.dart';
import 'package:textfield_search/textfield_search.dart';
import 'home_page.dart';

class Donate_Form extends StatefulWidget {
  const Donate_Form({Key? key}) : super(key: key);

  @override
  State<Donate_Form> createState() => _Donate_FormState();
}

class _Donate_FormState extends State<Donate_Form> {
  final namecontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final citycontroller = TextEditingController();
  double? lititudecon;
  double? longitudecon;
  bool location = false;
  final bloodcontroller = SingleValueDropDownController();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;


  //Cities list
  List<String> _cities = [
    "Badin", "Bhirkan", "Rajo Khanani", "Chak", "Dadu","Digri", "Diplo", "Dokri", "Ghotki", "Haala", "Hyderabad",
    "Islamkot", "Jacobabad", "Jamshoro", "Jungshahi", "Kandhkot", "Kandiaro", "Karachi", "Kashmore", "Keti Bandar",
    "Khairpur", "Kotri", "Larkana", "Matiari", "Mehar", "Mirpur Khas", "Mithani", "Mithi", "Mehrabpur", "Moro",
    "Nagarparkar","Naudero", "Naushahro Feroze", "Naushara", "Nawabshah", "Nazimabad", "Qambar", "Qasimabad", "Ranipur",
    "Ratodero", "Rohri", "Sakrand", "Sanghar", "Shahbandar", "Shahdadkot", "Shahdadpur", "Shahpur Chakar", "Shikarpaur",
    "Sukkur", "Tangwani", "Tando Adam Khan", "Tando Allahyar", "Tando Muhammad Khan", "Thatta", "Umerkot", "Warah"
  ];
  Future<Position> _getLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("Error" + error.toString());
    });
    return Geolocator.getCurrentPosition();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    namecontroller.dispose();
    numbercontroller.dispose();
    citycontroller.dispose();
    bloodcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back_ios,color: AppColor.greColor,)) ,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: _height * 0.04,),
                  Text("Donate Blood" , style: GoogleFonts.openSans(textStyle:TextStyle(color: Colors.red,fontWeight: FontWeight.w600, fontSize: 40) ) ,),
                  Text("Please! fill form for donate blood", style: GoogleFonts.openSans(textStyle:TextStyle(fontWeight: FontWeight.w300,color: AppColor.btxtColor))),
                  SizedBox(height: _height * 0.04,),
                  TextFormField(
                    style: GoogleFonts.openSans(),
                    validator: RequiredValidator(errorText: 'Name are Required'),
                    keyboardType: TextInputType.name,
                    controller: namecontroller,
                    decoration: const InputDecoration(
                      hintText: "Enter Name",
                    ),
                  ),
                  SizedBox(height: _height * 0.04),
                  TextFormField(
                    controller: numbercontroller,
                    keyboardType: TextInputType.number,
                    validator: RequiredValidator(errorText: 'Required'),
                    style: GoogleFonts.openSans(),
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                    ),
                  ),
                  SizedBox(height: _height * 0.04),
                  TextFieldSearch(
                    initialList: _cities,
                    textStyle:GoogleFonts.openSans(),
                    label: 'Enter City Name',
                    controller: citycontroller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      hintText: '@City Mirpurkhas',
                    ),
                  ),
                  SizedBox(height: _height * 0.04),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding:EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(8),
                          border: Border(bottom: BorderSide(width: 1.0,color: Colors.black38))),
                      child: InkWell(
                        onTap: () async {
                          _getLocation().then((value) {
                            setState(() {
                              location = true;
                              lititudecon = value.latitude.toDouble();
                              longitudecon = value.longitude.toDouble();
                            });
                            Utils().ToastMassage('Successfully Store');
                          },
                          ).onError((error, stackTrace) {
                            setState(() {
                              location = false;
                            });
                            Utils().ToastMassage("Error Location"+error.toString());
                          },
                          );
                        },
                        child:location?Text('Location are Store',style: TextStyle(fontSize: 16, color: Colors.black54)) : Text(
                          'Set Location',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )),
                  SizedBox(height: _height * 0.04),
                  DropDownTextField(
                    controller: bloodcontroller,
                    listTextStyle: GoogleFonts.openSans(),
                      textFieldDecoration: InputDecoration(
                        hintStyle: GoogleFonts.openSans(),
                          hintText: "Select Blood Group"
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      dropDownList: [
                        DropDownValueModel(name: 'A+', value: 'A+'),
                        DropDownValueModel(name: 'A-', value: 'A-'),
                        DropDownValueModel(name: 'B+', value: 'B+'),
                        DropDownValueModel(name: 'B-', value: 'A-'),
                        DropDownValueModel(name: 'O+', value: 'O+'),
                        DropDownValueModel(name: 'O-', value: 'O-'),
                        DropDownValueModel(name: 'AB+', value: 'AB+'),
                        DropDownValueModel(name: 'AB-', value: 'AB-'),
                      ]),
                  SizedBox(height: _height * 0.1,),
                  CustomButton(txt: 'Donation',loading: loading, ontop:(){
                    if (_formkey.currentState!.validate()) {
                      donate();
                    }else{
                      Utils().ToastMassage('Something wrong');
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

void donate() async{
    setState(() {
      loading = true;
    });
    final _firestore = FirebaseFirestore.instance.collection('Donation');
    // User? user = FirebaseAuth.instance.currentUser;
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _firestore.doc(id).set({
      'userid' : id,
      'name' : namecontroller.text,
      'number' : numbercontroller.text,
      'City' : citycontroller.text,
      'Latitude' : lititudecon!.toDouble(),
      'longitidue': longitudecon!.toDouble(),
      'bloodgroup' : bloodcontroller.dropDownValue!.name,
    }).then((value) {
      setState(() {
        loading = false;
      });
      Utils().ToastMassage('Thank you for donate');
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().ToastMassage(error.toString());
    });
    }
}

