import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_reservations/elevated_button_my_reservation.dart';
import './fhoto_gallery.dart';

import '../../models/museum_halls.dart';
import '../../models/user.dart';

import '../../providers/artworks.dart';
import '../../providers/users.dart';

class NavSuppPointItem extends StatelessWidget {
  final String loggedUsername = 'ttomiek';

  final MuseumHalls museumHallsData;

  NavSuppPointItem(this.museumHallsData);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final artworkList = Provider.of<Artworks>(context)
        .getArtworksByMuseumIdAndCategory(
            categoryId: museumHallsData.categoryId,
            museumId: museumHallsData.museumId);
    final User loggedUserData =
        Provider.of<Users>(context).findByUsername(loggedUsername);
    final bool admin =
        (loggedUserData.userRole == '1' || loggedUserData.userRole == '2') &&
                loggedUserData.museumId != null
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
                child: ElevatedButtonMyReservation('Edit', () {}),
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
        ComplicatedImageDemo(artworkList),
      ],
    );
  }
}
