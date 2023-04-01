// ignore_for_file: camel_case_types, sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names

import 'package:blood_bank_fyp/components/custombutton.dart';
import 'package:blood_bank_fyp/routes/routes_name.dart';
import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:blood_bank_fyp/utils/toastMassage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:textfield_search/textfield_search.dart';

class Add_Blood_Request extends StatefulWidget {
  const Add_Blood_Request({Key? key}) : super(key: key);

  @override
  State<Add_Blood_Request> createState() => _Add_Blood_RequestState();
}

class _Add_Blood_RequestState extends State<Add_Blood_Request> {
  final namecontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final bloodcontroller = SingleValueDropDownController();
  double? lititudecon;
  double? longitudecon;
  bool location = false;
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //We will get User Current Location through this function
  Future<Position> _getLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("Error" + error.toString());
    });
    return Geolocator.getCurrentPosition();
  }

  List<String> _cities = [
    "Badin", "Bhirkan", "Rajo Khanani", "Chak", "Dadu","Digri", "Diplo", "Dokri", "Ghotki", "Haala", "Hyderabad",
    "Islamkot", "Jacobabad", "Jamshoro", "Jungshahi", "Kandhkot", "Kandiaro", "Karachi", "Kashmore", "Keti Bandar",
    "Khairpur", "Kotri", "Larkana", "Matiari", "Mehar", "Mirpur Khas", "Mithani", "Mithi", "Mehrabpur", "Moro",
    "Nagarparkar","Naudero", "Naushahro Feroze", "Naushara", "Nawabshah", "Nazimabad", "Qambar", "Qasimabad", "Ranipur",
    "Ratodero", "Rohri", "Sakrand", "Sanghar", "Shahbandar", "Shahdadkot", "Shahdadpur", "Shahpur Chakar", "Shikarpaur",
    "Sukkur", "Tangwani", "Tando Adam Khan", "Tando Allahyar", "Tando Muhammad Khan", "Thatta", "Umerkot", "Warah"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cities;
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
    final height = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: Icon(Icons.arrow_back_ios,color: AppColor.greColor,)),
          backgroundColor: Colors.transparent,),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    //      Container(
                    //   width: double.infinity,
                    //   height: height * 0.3,
                    //   child: Image.asset(
                    //     'images/3.jpg',
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                  SizedBox(height: height * 0.06),
                  Text('Blood Request', style: GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 30,color: AppColor.redColor,fontWeight: FontWeight.w600)),),
                  Text("fill form for blood Request", style: GoogleFonts.openSans(textStyle:TextStyle(fontWeight: FontWeight.w300,color: AppColor.btxtColor))),
                  SizedBox(height: height * 0.05,),
                        CustomText('Enter Name', 'Name',namecontroller,TextInputType.name),
                  SizedBox(height:  height * 0.03,),
                       CustomText('Enter Number', 'Mobile Number',numbercontroller,TextInputType.number),
                  SizedBox(height:  height * 0.03,),
                  TextFieldSearch(
                    initialList: _cities,
                    label: 'Enter City Name',
                    controller: citycontroller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      hintText: '@City Mirpurkhas',
                    ),
                  ),
                  SizedBox(height:  height * 0.03,),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
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
                        child:location?Text('Location are store',style: TextStyle(fontSize: 16, color: Colors.black54)) : Text(
                          'Set Location',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )),
                  SizedBox(height:  height * 0.03,),
                         DropDownTextField(
                          controller: bloodcontroller,
                    listTextStyle: GoogleFonts.openSans(),
                      textFieldDecoration: InputDecoration(
                        hintStyle: GoogleFonts.openSans(),
                          hintText: "Select Blood Group"
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      dropDownList: [
                        const DropDownValueModel(name: 'A+', value: 'A+'),
                        const DropDownValueModel(name: 'A-', value: 'A-'),
                        const DropDownValueModel(name: 'B+', value: 'B+'),
                        const DropDownValueModel(name: 'B-', value: 'A-'),
                        const DropDownValueModel(name: 'O+', value: 'O+'),
                        const DropDownValueModel(name: 'O-', value: 'O-'),
                        const DropDownValueModel(name: 'AB+', value: 'AB+'),
                        const DropDownValueModel(name: 'AB-', value: 'AB-'),
                      ]),
                  SizedBox(height:  height * 0.05,),
                  CustomButton(txt: 'Add Request',loading: loading, ontop: (){
                      if(_formkey.currentState!.validate()){
                      add_request();
                    }else{
                        Utils().ToastMassage('something wrong');
                    }
                  }),
                ],
              ),
            ),
          ),
        )
    );
  }



void add_request() async{
    setState(() {
      loading = true;
    });
    final firestore = FirebaseFirestore.instance.collection('Add_request');
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    firestore.doc(id).set({
      'userid' : id,
      'name' : namecontroller.text,
      'address' : citycontroller.text,
      'number' : numbercontroller.text,
      'Latitude' : lititudecon!.toDouble(),
      'longitidue': longitudecon!.toDouble(),
      'bloodgroup' : bloodcontroller.dropDownValue!.name,
    }).then((value) {
      setState(() {
        loading = false;
      });
      Utils().ToastMassage('Request submitted');
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().ToastMassage(error.toString());
    });
    }


  TextFormField CustomText(String text,String label,var controller,var keytype) {
  return TextFormField(
      style: GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 15)),
      controller: controller ,
      keyboardType: keytype,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          hintText: text,
          label: Text(label),
      ),
      validator: (value){
        if(value!.isEmpty){
          return "Please Fill this Field";
        }
      },
  );
}
}

