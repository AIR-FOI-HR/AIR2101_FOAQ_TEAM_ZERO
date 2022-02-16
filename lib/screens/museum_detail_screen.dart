import 'package:flutter/material.dart';
import 'package:museum_app/screens/ticket_purchase/ticket_purchase_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';
import '../widgets/museumDetails/artworks_grid.dart';

import '../../models/user.dart';
import '../providers/museums.dart';
import '../../providers/users.dart';

import '../screens/login/login_screen.dart';

class MuseumDetailScreen extends StatelessWidget {
  static const routeName =
      '/museum-detail'; //namedroute for pushing named from MuseumOverviewScree

  void _launchURL(String url) async {
    if (url == null) {
      return;
    }
    if (!await launch(url)) throw 'Could not open $url';
  }

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context).getUser();
    final museumId = ModalRoute.of(context).settings.arguments
        as String; //get id when routed to  museum detail screen
    final museum = Provider.of<Museums>(context)
        .getById(museumId); //get museum by id from Museums provider
    return Scaffold(
      appBar: appBar(
          museum.name, context, Theme.of(context).highlightColor, appUser),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //top image
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.network(
                museum.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Theme.of(context).highlightColor,
              endIndent: 50,
              indent: 50,
            ),
            //about 'museum' text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              child: Text('About ${museum.name}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            //description, map and addres
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                          color: Theme.of(context).accentColor,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  'Description: ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              const Divider(
                                height: 5,
                                color: Colors.white,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  museum.description,
                                  style: const TextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  //spacer betwen map and description,addres
                  const SizedBox(
                    width: 15,
                  ),
                  //map
                  Expanded(
                    flex: 1,
                    child: Material(
                      elevation: 10,
                      //adress
                      child: Container(
                        color: Theme.of(context).highlightColor,
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
                            const Divider(
                              height: 5,
                              color: Colors.white,
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
                              child: GestureDetector(
                                onTap: () {
                                  _launchURL(museum.location);
                                },
                                child: Material(
                                  elevation: 20,
                                  child: SizedBox(
                                    height: 200,
                                    child: Image.network(
                                      'https://i.stack.imgur.com/uBnTY.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
              child: Text('Gallery of ${museum.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ArtworksGrid(museumId),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          appUser == null
              ? Navigator.of(context).pushNamed(LoginScreen.routeName)
              : Navigator.of(context).pushNamed(TicketPurchaseScreen.routeName);
        },
        child: IconButton(
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
