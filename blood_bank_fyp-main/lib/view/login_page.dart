// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, unused_local_variable, duplicate_ignore, non_constant_identifier_names

import 'package:blood_bank_fyp/components/custombutton.dart';
import 'package:blood_bank_fyp/components/forgot_password.dart';
import 'package:blood_bank_fyp/routes/routes_name.dart';
import 'package:blood_bank_fyp/utils/app_color.dart';
import 'package:blood_bank_fyp/utils/toastMassage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/quickalert.dart';
import '../utils/ordriver.dart';


class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  bool showpassword = true;
  bool loading = false;

  void _googlesign()async{
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );
     _auth.signInWithCredential(credential).then((value){
       if(FirebaseAuth.instance.currentUser != null){
         Utils().ToastMassage('Google Authantication is Successfully');
         Navigator.pushNamed(context, RoutesName.home);
       }
     }).onError((error, stackTrace){

       Utils().ToastMassage(error.toString());
     });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height * 0.8;
    final _width = MediaQuery.of(context).size.width * 0.8;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
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
                      'images/1.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                SizedBox(height: _height * 0.02),
                  Text(
                    "Login",
                    style:GoogleFonts.openSans(textStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(height:_height * 0.02),
                  Text('Email',style:GoogleFonts.openSans(textStyle:TextStyle(fontSize:15,fontWeight: FontWeight.w600),),),
                  SizedBox(height:_height * 0.01),
                  BuildTextForm(
                      'Enter Email',
                      Icon(Icons.email),
                      MultiValidator([
                        EmailValidator(errorText: 'Invalid Email'),
                        RequiredValidator(errorText: 'Required')
                      ]),
                      emailcontroller,
                      TextInputType.emailAddress,
                      false),
                  SizedBox(height:_height * 0.01),
                  Text('Password',style:GoogleFonts.openSans(textStyle:TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),),
                  SizedBox(height:_height * 0.01),
                  BuildTextForm(
                      'Enter Password',
                      Icon(Icons.lock),
                        RequiredValidator(errorText: 'Required')
                      ,
                      passwordcontroller,
                      TextInputType.visiblePassword,
                      true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot_Password()));
                          },
                          child: Text("Forget Password",
                              // ignore: prefer_const_constructors
                              style:GoogleFonts.openSans(textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))))
                    ],
                  ),
                SizedBox(height:_height * 0.02),
                CustomButton(txt: 'Login',loading: loading, ontop: (){
                  if(formkey.currentState!.validate()){
                    login();
                  }else{
                    Utils().ToastMassage('Something Wrong');
                  }
                }),
                SizedBox(height:_height * 0.03),
                  OrDivider(),
                  SizedBox(height:_height * 0.03),
                  InkWell(
                    onTap: () {
                      _googlesign();
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black45)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/google.png',width: 25,height: 25,),
                          SizedBox(width: 10),
                          Text(
                              "Sign in with Google",
                              // ignore: prefer_const_constructors
                              style:GoogleFonts.openSans(textStyle:  TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),)

                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "If havn't an account? ",
                        style:GoogleFonts.openSans(textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
                      )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.register);
                          },
                          child: Text("Register",
                              // ignore: prefer_const_constructors
                              style:GoogleFonts.openSans(textStyle:TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700))))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value){
      Utils().ToastMassage('Welcome To Blood Bank');
      Navigator.pushNamed(context, RoutesName.home);
        setState(() {
      loading = false;
    });
    }).onError((error, stackTrace){
        setState(() {
      loading = false;
    });
      Utils().ToastMassage(error.toString());
    });
  }

  TextFormField BuildTextForm(String title, var shape,
      String? Function(String?)? txtvalidate, var controller, var keytype,bool passwordhide) {
    return TextFormField(
      style: GoogleFonts.openSans(),
      keyboardType: keytype,
      validator: txtvalidate,
      controller: controller,
      obscureText: passwordhide ? showpassword: false,
      decoration: InputDecoration(
          prefixIcon: shape,
          prefixIconColor: Colors.blue,
          suffixIcon: passwordhide
              ? IconButton(
            onPressed: () {
              setState(() {
                showpassword = !showpassword;
              });
            },
            icon:showpassword? Icon(Icons.visibility_off):Icon(Icons.visibility),
          )
              : null,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          hintText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
