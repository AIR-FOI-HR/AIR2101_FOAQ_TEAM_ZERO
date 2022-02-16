import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_reservations/elevated_button_my_reservation.dart';
import './fhoto_gallery.dart';
import '../../screens/navigation_support/museum_nav_supp_crud_screen.dart';

import '../../models/museum_halls.dart';
import '../../models/user.dart';

import '../../providers/artworks.dart';
import '../../providers/users.dart';

class NavSuppPointItem extends StatelessWidget {
  final MuseumHalls museumHallsData;

  NavSuppPointItem(this.museumHallsData);

  @override
  Widget build(BuildContext context) {
    User appUser = Provider.of<Users>(context, listen: false).getUser();
    final artworkList = Provider.of<Artworks>(context, listen: false)
        .getArtworksByMuseumIdAndCategory(
            categoryId: museumHallsData.categoryId,
            museumId: museumHallsData.museumId);
    final bool admin = (appUser.userRole == '2' || appUser.userRole == '3') &&
            appUser.museumId != null
        ? true
        : false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${museumHallsData.order}. point - ${museumHallsData.name}',
              style: Theme.of(context).textTheme.headline4,
            ),
            if (admin)
              SizedBox(
                height: 30,
                child: ElevatedButtonMyReservation('Edit', () {
                  Navigator.of(context)
                      .pushNamed(MuseumNavSuppCrudScreen.routeName, arguments: {
                    'museumId': museumHallsData.museumId,
                    'museumHallId': museumHallsData.id,
                  });
                }),
              ),
          ],
        ),
        if (museumHallsData.description != null &&
            museumHallsData.description != '')
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Text(
              museumHallsData.description ?? 'No description',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        const SizedBox(height: 5),
        if (artworkList.isNotEmpty) ComplicatedImageDemo(artworkList),
      ],
    );
  }
}
