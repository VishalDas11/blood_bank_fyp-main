import 'package:blood_bank_fyp/components/custombutton.dart';
import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:blood_bank_fyp/utils/toastMassage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({Key? key}) : super(key: key);

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  final emailcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery
        .of(context)
        .size
        .height * 0.8;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
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
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Container(
                    width: double.infinity,
                    height: _height * 0.4,
                    child: Image.asset(
                      'images/2.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  Text(
                      "Forgot Password",
                      style: GoogleFonts.openSans(textStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: _height * 0.02),
                  Text('Email', style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),),),
                  SizedBox(height: _height * 0.01),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                    hintText: 'Enter Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                    validator: MultiValidator([
                      EmailValidator(errorText: 'Invalid Email'),
                      RequiredValidator(errorText: 'Required')
                    ]),),
                  SizedBox(height: _height * 0.04),
                      CustomButton(txt: 'Forgot Password', ontop: (){
                        setState(() {
                          loading = true;
                        });
                        _auth.sendPasswordResetEmail(email: emailcontroller.text.toString()).then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().ToastMassage('we have send email to recover password, Please Check your email');
                        }).onError((error, stackTrace){
                          setState(() {
                            loading = false;
                          });
                          Utils().ToastMassage(error.toString());
                        });
                      },loading: loading,)
                ])
            )
        )
    ));
  }
}
