import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';

import '../providers/museums.dart';

class MuseumDetailScreen extends StatelessWidget {
  static const routeName =
      '/museum-detail'; //namedroute for pushing named from MuseumOverviewScree

  @override
  Widget build(BuildContext context) {
    final museumId = ModalRoute.of(context).settings.arguments
        as String; //get id when routed to  museum detail screen
    final museum = Provider.of<Museums>(context)
        .getById(museumId); //get museum by id from Museums provider
    return Scaffold(
      appBar: appBar(museum.name, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //top image
            Container(
              height: 150,
              width: double.infinity,
              child: Image.asset(
                museum.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              thickness: 1.5,
              height: 10,
              color: Theme.of(context).primaryColorLight,
            ),
            //description, map and addres
            Padding(
              padding: const EdgeInsets.only(left:10, right:10),
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
                          color:
                              Theme.of(context).highlightColor.withOpacity(0.4),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 10),
                                child: const Text(
                                  'Description: ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                              Divider(
                                height: 5,
                                color: Theme.of(context).primaryColor,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  museum.description,
                                  style: TextStyle(),
                                  textAlign: TextAlign.center,
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
                  //spacer betwen map and description,addres
                  SizedBox(
                    width: 15,
                  ),
                  //map
                  Expanded(
                    flex: 1,
                    child: Material(
                      elevation: 10,
                      //adress
                      child: Container(
                        color: Theme.of(context).accentColor.withOpacity(0.5),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 10),
                              child: const Text(
                                'Address: ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Divider(
                              height: 5,
                              color: Theme.of(context).primaryColor,
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                museum.address,
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: 200,
                                child: Image.network(
                                  'https://i.stack.imgur.com/uBnTY.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
