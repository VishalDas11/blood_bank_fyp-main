import 'package:blood_bank_fyp/components/custombutton.dart';
import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:textfield_search/textfield_search.dart';
import '../routes/routes_name.dart';
import '../utils/toastMassage.dart';

class Register_Form extends StatefulWidget {
  const Register_Form({Key? key}) : super(key: key);
  @override
  State<Register_Form> createState() => _Register_FormState();
}
class _Register_FormState extends State<Register_Form> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final groupcontroller = SingleValueDropDownController();
  bool location = false;
  bool showpassword = true;
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    namecontroller.dispose();
    emailcontroller.dispose();
    mobilecontroller.dispose();
    citycontroller.dispose();
    passwordcontroller.dispose();
    groupcontroller.dispose();
  }

  //Cities list
  final List<String> _cities = [
    "Badin", "Bhirkan", "Rajo Khanani", "Chak", "Dadu","Digri", "Diplo", "Dokri", "Ghotki", "Haala", "Hyderabad",
    "Islamkot", "Jacobabad", "Jamshoro", "Jungshahi", "Kandhkot", "Kandiaro", "Karachi", "Kashmore", "Keti Bandar",
    "Khairpur", "Kotri", "Larkana", "Matiari", "Mehar", "Mirpur Khas", "Mithani", "Mithi", "Mehrabpur", "Moro",
    "Nagarparkar","Naudero", "Naushahro Feroze", "Naushara", "Nawabshah", "Nazimabad", "Qambar", "Qasimabad", "Ranipur",
    "Ratodero", "Rohri", "Sakrand", "Sanghar", "Shahbandar", "Shahdadkot", "Shahdadpur", "Shahpur Chakar", "Shikarpaur",
    "Sukkur", "Tangwani", "Tando Adam Khan", "Tando Allahyar", "Tando Muhammad Khan", "Thatta", "Umerkot", "Warah"
  ];

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height * 0.8;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.arrow_back_ios,color: Colors.grey,),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(height: hieght * 0.06),
                  BuildTextForm('Full Name',const Icon(Icons.person_outline_rounded), MultiValidator([
                    RequiredValidator(errorText: 'Required')
                  ]), namecontroller, TextInputType.name, false),
                  SizedBox(height: hieght * 0.04),
                  BuildTextForm('Email Address',const Icon(Icons.email_outlined), MultiValidator([
                    RequiredValidator(errorText: 'Required'),
                  ]),emailcontroller, TextInputType.emailAddress, false),
                  SizedBox(height: hieght * 0.04),
                  BuildTextForm('Mobile',const Icon(Icons.phone_outlined), MultiValidator([
                    RequiredValidator(errorText: 'Required'),
                    MaxLengthValidator(11, errorText: 'Atleast 11 digits'),
                  ]), mobilecontroller, TextInputType.number, false),
                  SizedBox(height: hieght * 0.04),
                  TextFieldSearch(
                    initialList: _cities,
                    label: 'Enter City Name',
                    controller: citycontroller,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_city_rounded),
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        hintText: '@city Mirpurkhas',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: hieght * 0.04),
                  BuildTextForm('Password',const Icon(Icons.lock_outline), MultiValidator([
                    MinLengthValidator(6, errorText: 'Atleast 8 digits'),
                    MaxLengthValidator(15, errorText: 'Atleast 15 digits'),
                    PatternValidator(r'(?=.*?[!@#$%^&*?-])', errorText: 'Using Special character'),
                    RequiredValidator(errorText: 'Required')
                  ]), passwordcontroller, TextInputType.visiblePassword, true),
                  // SizedBox(height: _hieght * 0.04),
                  // Container(
                  //     alignment: Alignment.centerLeft,
                  //     padding:
                  //     EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  //     width: double.infinity,
                  //     height: 45,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(color: Colors.black38)),
                  //     child: InkWell(
                  //       onTap: () async {
                  //         _getLocation().then((value) {
                  //           setState(() {
                  //             location = true;
                  //             lititudecon = value.latitude.toDouble();
                  //             longitudecon = value.longitude.toDouble();
                  //           });
                  //           print('Current Location');
                  //           print("Latitude " +
                  //               value.latitude.toString() +
                  //               " *** Longitude " +
                  //               value.longitude.toString());
                  //           Utils().ToastMassage('Success Store');
                  //         },
                  //         ).onError((error, stackTrace) {
                  //           setState(() {
                  //             location = false;
                  //           });
                  //           Utils().ToastMassage("Error Location"+error.toString());
                  //           print(error.toString());
                  //         },
                  //         );
                  //       },
                  //       child:location?Text('Done',style: TextStyle(fontSize: 16, color: Colors.black54)) : Text(
                  //         'Set Location',
                  //         style: TextStyle(fontSize: 16, color: Colors.black54),
                  //       ),
                  //     )),
                  SizedBox(height: hieght* 0.04),
                  DropDownTextField(
                      textFieldDecoration: InputDecoration(
                          hintStyle: GoogleFonts.openSans(),
                          hintText: "Select Blood Group"
                      ),
                      controller: groupcontroller,
                      dropDownList: const [
                        DropDownValueModel(name: 'A+', value: 'A+'),
                        DropDownValueModel(name: 'A-', value: 'A-'),
                        DropDownValueModel(name: 'B+', value: 'B+'),
                        DropDownValueModel(name: 'B-', value: 'A-'),
                        DropDownValueModel(name: 'O+', value: 'O+'),
                        DropDownValueModel(name: 'O-', value: 'O-'),
                        DropDownValueModel(name: 'AB+', value: 'AB+'),
                        DropDownValueModel(name: 'AB-', value: 'AB-'),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(txt: "Register",
                      loading: loading,
                      ontop: (){
                    if(formkey.currentState!.validate()){
                      register();
                    }else{
                      Utils().ToastMassage('Something wrong');
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, RoutesName.login);
                      }, child: const Text( "Login",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

Future<void> register() async{
    final firestore = FirebaseFirestore.instance.collection('Data');
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    setState(() {
      loading  = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text
    ).then((value){
      firestore.doc(id).set({
        'id' : id,
        'name' : namecontroller.text,
        'email' : emailcontroller.text,
        'mobile' : mobilecontroller.text,
        'city' : citycontroller.text,
        'password' : passwordcontroller.text,
        'blood Group' : groupcontroller.dropDownValue!.name
      });
      Utils().ToastMassage('Successfully Store');
      setState(() {
        loading = false;
        Navigator.pushNamed(context, RoutesName.login);
      });
    }).onError((error, stackTrace){
        setState(() {
      loading  = false;
    });
      Utils().ToastMassage("Error Register$error");
    });
}

  TextFormField BuildTextForm(String title,var shape,
      String? Function(String?)? txtvalidate, var controller, var keytype,bool passwordhide) {
    return TextFormField(
      style: GoogleFonts.openSans(),
      keyboardType: keytype,
      validator: txtvalidate,
      controller: controller,
      obscureText: passwordhide ? showpassword : false,
      decoration: InputDecoration(
        prefixIcon: shape,
          suffixIcon: passwordhide
              ? IconButton(
            onPressed: () {
              setState(() {
                showpassword = !showpassword;
              });
            },
            icon:showpassword?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
          )
              : null,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          hintText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}


