import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/widgets/app_bar.dart';
import 'package:museum_app/widgets/main_menu_drawer.dart';
import 'package:provider/provider.dart';

class Person {
  String name;
  String profileImg;
  String bio;
  Person({this.name, this.profileImg, this.bio});
}

class AboutUs extends StatelessWidget {
  static const routeName = '/aboutUs';
  List<Person> persons = [
    Person(
        name: 'Tomislav Tomiek',
        profileImg:
            'https://i.pinimg.com/originals/a7/90/d9/a790d99f501abbd1223333537ee907e0.jpg',
        bio: "ttomiek@foi.hr"),
    Person(
        name: 'Borna Rosandić',
        profileImg:
            'https://i.pinimg.com/originals/10/3f/94/103f94e3ac344fffb634b362c7ddde3a.png',
        bio: "brosandic@foi.hr"),
    Person(
        name: 'Martin Sakač',
        profileImg:
            'https://i.pinimg.com/originals/32/e8/41/32e841d1920970c4ef5237df0cca80d5.jpg',
        bio: "msakac@foi.hr"),
    Person(
        name: 'Mariia Smirnova',
        profileImg:
            'https://i.pinimg.com/originals/0d/5c/7d/0d5c7d4737cd45ccbd124d5d99ee28a2.jpg',
        bio: "mariia.smirnova@student.univaq.it "),
  ];

  Widget personDetailCard(Person, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(Person.profileImg)))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Person.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Person.bio,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    return Scaffold(
      appBar:
          appBar('About us', context, Theme.of(context).primaryColor, appUser),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //top image
            Container(
              height: 150,
              width: double.infinity,
              child: Image.network(
                'https://img.freepik.com/free-photo/contact-us-customer-support-hotline-people-connect-call-customer-support_36325-2023.jpg?size=626&ext=jpg',
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Theme.of(context).highlightColor,
              endIndent: 20,
              indent: 20,
            ),
            //about 'museum' text
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, bottom: 5),
              child: Text('About Team Foaq Zero',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            //description, map and addres
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //description and address
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        //description
                        Container(
                          color: Theme.of(context).highlightColor,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 10),
                                child: const Text(
                                  'Who are we? ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              const Divider(
                                height: 5,
                                color: Colors.white,
                                thickness: 1,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5, left: 10, right: 10),
                                child: Text(
                                  '    We are ambitious and hard working graduate students of Information and Software Engineering at Faculty Of Organization and Informatics situated in city of Varaždin in Croatia.',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Theme.of(context).highlightColor,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 10),
                                child: const Text(
                                  'Museum App ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              const Divider(
                                height: 5,
                                color: Colors.white,
                                thickness: 1,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5, left: 10, right: 10),
                                child: Text(
                                  "    Museum App was a product of collaboration between Faculty of Organization of Informatics and University of L'Aquila on the course of Analysis and Program Development.\n    Under the guidance of Assoc. Prof. Zlatko Stapić Ph. D. and Full Prof. Henry Muccini Ph. D., we have designed complete Architecture description, Application Wireframe and Implemented the Application with Flutter SDK and Firebase Baas.\n    For creating documentation and monitoring process of program development, we use Atlassion tools Jira and Confluence. ",
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Theme.of(context).highlightColor,
              endIndent: 50,
              indent: 50,
            ),
            //'museum' gallery
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, bottom: 5),
              child: Text('Contact us',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(
                  children: persons.map((p) {
                return personDetailCard(p, context);
              }).toList()),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Text('2022 \u00a9 Team FOAQ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      drawer: MainMenuDrawer(),
    );
  }
}
