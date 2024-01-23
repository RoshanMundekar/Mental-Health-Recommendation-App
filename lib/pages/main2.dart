
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentalhealthrecomendation/pages/login_page.dart';
import 'package:mentalhealthrecomendation/pages/main2.dart';
import 'package:mentalhealthrecomendation/pages/splash_screen.dart';
import 'package:mentalhealthrecomendation/pages/widgets/header_widget.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhealthrecomendation/screens/quiz_screen.dart';
import '../data/biologiya_quiz_repository.dart';
import '../data/englesh_quiz_repository.dart';
import '../data/math_quiz_repository.dart';
import '../data/sport_quiz_repository.dart';
import '../model/quiz_data.dart';
import '../my-globals.dart';

import '../server.dart';
import 'mcq1.dart';
import 'registration_page.dart';



class ProfilePage2 extends StatefulWidget{
  const ProfilePage2({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
     return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage2>{


  State<ProfilePage2> createState() => _ProfilePageState();
  // List characterList = [];
  List<QuizData> biologiyaSet = BiologiyaQuizRepository.biologySet();
  List<QuizData> englishSet = EngleshQuizRepository.engleshSet();
  List<QuizData> mathSet = MathQuizRepository.mathSet();
  List<QuizData> sportSet = SportQuizRepository.sportSet();
  // void getCharactersfromApi() async {
  //   CharacterApi.getCharacters().then((response) {
  //     setState(() {
  //       Iterable list = json.decode(response.body);
  //       print(list);
  //       characterList.addAll(list) ;
  //       // Iterable list = json.decode(response.body);
  //       // characterList = list;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page",
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

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 100, child: const HeaderWidget(100,false,Icons.house_rounded),),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(5, 5),),
                      ],
                    ),
                    child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                  ),
                  const SizedBox(height: 20,),
                  const SizedBox(height: 20,),

                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[

                                Column(

                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          title: Text('Item 1'),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfilePage3()),
                                            );
                                            print("Clicked");
                                          },

                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          title: Text('Item 2'),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfilePage3()),
                                            );
                                            print("Clicked");
                                          },

                                        ),



                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          title: Text('Item 3'),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfilePage3()),
                                            );
                                            print("Clicked");
                                          },

                                        ),


                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          title: Text('Item 4'),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfilePage3()),
                                            );
                                            print("Clicked");
                                          },

                                        ),



                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

}

class CharacterApi {
  static Future getCharacters() {
    return http.get(Uri.parse(serverurl+"getProfile/"+globalString));
  }
}
