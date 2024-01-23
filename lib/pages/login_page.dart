
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealthrecomendation/common/theme_helper.dart';

import '../my-globals.dart';
import '../server.dart';
import 'package:http/http.dart' as http;
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  var fname = TextEditingController();
  var Password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.health_and_safety), //let's create a common header widget
            ),
            SafeArea(
              child: Container( 
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    const Text(
                      'Mental Health Recomendation',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextField(
                                controller: fname,
                                decoration: ThemeHelper().textInputDecoration('User Name', 'Enter your user name'),
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Container(
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextField(
                                controller: Password,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => const ForgotPasswordPage()), );
                                },
                                child: const Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: ()async{
                                  String text1,text2;
                                  text1 = fname.text ;
                                  text2 = Password.text ;
                                  if(text1 == '' || text2 == '' )
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text("Result"),
                                          content: Text('Text Field is empty, Please Fill All Data'),
                                          actions: [
                                          ],
                                        );
                                      },
                                    );
                                  }else{

                                    //url to send the post request to
                                    final url = serverurl+"login";

                                    //sending a post request to the url
                                    final response = await http.post(Uri.parse(url), body: json.encode({'fname' : text1,'pass' : text2}));

                                    String responseBody = response.body;

                                    if(responseBody == "success"){
                                      globalString = text1;
                                      Navigator.pushReplacementNamed(context, "/home");
                                    }else{
                                      print("My text ${text1} and ${text2}");
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          Widget okButton = TextButton(
                                            child: const Text("OK"),
                                            onPressed: (){
                                              Navigator.push( context, MaterialPageRoute( builder: (context) => LoginPage()), );
                                            },
                                          );
                                          return AlertDialog(
                                            title: const Text("Result"),
                                            content: const Text("Invalid username and password.\nYou need to login again."),
                                            actions: [
                                              okButton,
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }



                                  //After successful login we will redirect to profile page. Let's create profile page now
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
}