
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentalhealthrecomendation/pages/login_page.dart';
import 'package:mentalhealthrecomendation/pages/main2.dart';
import 'package:mentalhealthrecomendation/pages/splash_screen.dart';
import 'package:mentalhealthrecomendation/pages/widgets/header_widget.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhealthrecomendation/screens/quiz_screen.dart';
import '../model/quiz_data.dart';
import '../my-globals.dart';
import '../screens/my_quiz_screen.dart';
import '../server.dart';
import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';

class ProfilePage3 extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
     return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage3>{

  List characterList = [];

  int seed = 0;
  void getCharactersfromApi() async {
    CharacterApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        print(list);
        characterList.addAll(list) ;
        // Iterable list = json.decode(response.body);
        // characterList = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCharactersfromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("question Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
              )
          ),
        ),
        actions: [

        ],
      ),

      body: ListView.builder(
        itemCount: characterList.length,
        itemBuilder: (context, index) {
          return  Card(
            margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            elevation: 1.5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(20),
                child:
                Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text((index+1).toString()+") "),
                        ),
                        Expanded(
                          flex: 10,
                          child: AutoSizeText(characterList[index][1])
                        ),
                      ],
                    ),

                    Divider(thickness: 1,),

                    RadioListTile(
                      title: AutoSizeText(characterList[index][2]),
                      value: characterList[index][2].toString(),
                      groupValue: characterList[index][0],
                      onChanged: (value){
                        setState(() {
                          characterList[index][0]=value.toString();
                          if(characterList[index][6].toString()==value)
                          {
                            seed++;
                          }
                        });
                      },
                    ),

                    RadioListTile(
                      title: AutoSizeText(characterList[index][3]),
                      value: characterList[index][3].toString(),
                      groupValue: characterList[index][0],
                      onChanged: (value){
                        characterList[index][0]=value.toString();
                        setState(() {
                          if(characterList[index][6].toString()==value)
                          {
                            seed++;
                          }
                        });
                      },
                    ),

                    RadioListTile(
                      title: AutoSizeText(characterList[index][4]),
                      value: characterList[index][4].toString(),
                      groupValue: characterList[index][0],
                      onChanged: (value){
                        setState(() {
                          characterList[index][0]=value.toString();
                        });
                      },
                    ),

                    RadioListTile(
                      title: AutoSizeText(characterList[index][5]),
                      value: characterList[index][5].toString(),
                      groupValue: characterList[index][0],
                      onChanged: (value){
                        setState(() {
                          characterList[index][0]=value.toString();
                        });
                      },
                    )



                  ],




                ),


              ),

            ),


          );

        },

      ),

    );

  }

}

class CharacterApi {
  static Future getCharacters() {
    return http.get(Uri.parse(serverurl+"getquestions"));
  }
}
