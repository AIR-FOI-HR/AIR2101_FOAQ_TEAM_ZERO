// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../models/museum.dart';
import '../models/category_artwork.dart';
import '../models/artwork.dart';
import '../providers/categories.dart';
import '../providers/artworks.dart';

class Museums with ChangeNotifier {
  Artworks artworks = new Artworks();
  // List<Museum> _museums = [
  //   Museum(
  //       id: '1',
  //       name: 'Gladiator Museum',
  //       address: 'Piazza Navona 90, Roma, Italy',
  //       description:
  //           'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
  //       tourDuration: 45,
  //       imageUrl: 'assets/images/Gladiator.png',
  //       location:
  //           'https://www.google.com/maps/place/Gladiator+museum/@41.8989508,12.4712464,17z/data=!3m1!4b1!4m5!3m4!1s0x132f604fe38ab94f:0x1bbf5eaf6454aaf5!8m2!3d41.8989508!4d12.4734351'),
  //   Museum(
  //       id: '2',
  //       name: 'Doria Pamhili Gallery',
  //       address: 'Via del Corso 305, Roma, Italy',
  //       description:
  //           'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
  //       tourDuration: 50,
  //       imageUrl: 'assets/images/Doria_Pamphili.png',
  //       location:
  //           'https://www.google.com/maps/place/Doria+Pamphili+Gallery/@41.8958655,12.47826,16.13z/data=!3m1!5s0x132f604d75c4a7f9:0x92347bb544c072b!4m9!1m2!2m1!1sgalleria+doria+pamphilj+maps!3m5!1s0x132f604d7b1b4a17:0xc690f450b64792d0!8m2!3d41.8979782!4d12.4815742!15sChxnYWxsZXJpYSBkb3JpYSBwYW1waGlsaiBtYXBzkgEGbXVzZXVt'),
  //   Museum(
  //       id: '3',
  //       name: 'Capitoline Museum',
  //       address: 'Piazza del Campidoglio 1, Roma, Italy',
  //       description:
  //           'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
  //       tourDuration: 30,
  //       location:
  //           'https://www.google.com/maps/place/Capitoline+Museum,+Piazza+del+Campidoglio,+Rim,+Italija/@41.8929428,12.480369,17z/data=!4m5!3m4!1s0x132f604f7906ecf3:0xdea1467ab6c9ecfb!8m2!3d41.8929428!4d12.4825577',
  //       imageUrl: 'assets/images/Capitolini.png'),
  //   Museum(
  //       id: '4',
  //       name: 'Uffizi',
  //       address: 'Piazzale degli Uffizi 6, Firenze, Italy',
  //       description:
  //           'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
  //       tourDuration: 30,
  //       location:
  //           'https://www.google.com/maps/place/Uffizi/@43.7677895,11.2531221,17z/data=!3m2!4b1!5s0x132a540087230dbb:0xff95595eb045fc7b!4m5!3m4!1s0x132a54008dc59081:0xcddeb7c89bf0c4cd!8m2!3d43.7677856!4d11.2553108',
  //       imageUrl: 'assets/images/Uffizi.png'),
  //   Museum(
  //       id: '5',
  //       name: 'Brera',
  //       address: 'Via Brera 28, Milano, Italy',
  //       description:
  //           'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
  //       tourDuration: 30,
  //       imageUrl: 'assets/images/Brera.png',
  //       location:
  //           'https://www.google.com/maps/place/Brera/@45.4719582,9.1856258,17z/data=!3m1!4b1!4m5!3m4!1s0x4786ee11587e4e1f:0x1b367a8e2cb13736!8m2!3d45.4719545!4d9.1878145'),
  //   Museum(
  //       id: '6',
  //       name: 'Museum Egizio',
  //       address: 'Via Accademia delle Scienze 6, Torino, Italy',
  //       description:
  //           'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
  //       tourDuration: 30,
  //       imageUrl: 'assets/images/Egizio.png',
  //       location:
  //           'https://www.google.com/maps/place/Museo+Egizio,+Castello+Sforzesco,+Piazza+Castello,+Milano,+Metropolitan+City+of+Milan,+Italija/@45.4719582,9.1856258,17z/data=!4m5!3m4!1s0x4786c14df358bf37:0x5b7124c3b265c967!8m2!3d45.471013!4d9.1798188'),
  // ];

  //mockup data of museums
  List<Museum> _museums = [
    Museum(
        id: '1',
        name: 'Gladiator Museum',
        address: 'Piazza Navona 90, Roma, Italy',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 45,
        imageUrl: 'assets/images/Gladiator.png',
        capacity: 10,
        location:
            'https://www.google.com/maps/place/Gladiator+museum/@41.8989508,12.4712464,17z/data=!3m1!4b1!4m5!3m4!1s0x132f604fe38ab94f:0x1bbf5eaf6454aaf5!8m2!3d41.8989508!4d12.4734351'),
    Museum(
        id: '2',
        name: 'Doria Pamhili Gallery',
        address: 'Via del Corso 305, Roma, Italy',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 50,
        imageUrl: 'assets/images/Doria_Pamphili.png',
        location:
            'https://www.google.com/maps/place/Doria+Pamphili+Gallery/@41.8958655,12.47826,16.13z/data=!3m1!5s0x132f604d75c4a7f9:0x92347bb544c072b!4m9!1m2!2m1!1sgalleria+doria+pamphilj+maps!3m5!1s0x132f604d7b1b4a17:0xc690f450b64792d0!8m2!3d41.8979782!4d12.4815742!15sChxnYWxsZXJpYSBkb3JpYSBwYW1waGlsaiBtYXBzkgEGbXVzZXVt'),
    Museum(
        id: '3',
        name: 'Capitoline Museum',
        address: 'Piazza del Campidoglio 1, Roma, Italy',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 30,
        location:
            'https://www.google.com/maps/place/Capitoline+Museum,+Piazza+del+Campidoglio,+Rim,+Italija/@41.8929428,12.480369,17z/data=!4m5!3m4!1s0x132f604f7906ecf3:0xdea1467ab6c9ecfb!8m2!3d41.8929428!4d12.4825577',
        imageUrl: 'assets/images/Capitolini.png'),
    Museum(
        id: '4',
        name: 'Uffizi',
        address: 'Piazzale degli Uffizi 6, Firenze, Italy',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 30,
        location:
            'https://www.google.com/maps/place/Uffizi/@43.7677895,11.2531221,17z/data=!3m2!4b1!5s0x132a540087230dbb:0xff95595eb045fc7b!4m5!3m4!1s0x132a54008dc59081:0xcddeb7c89bf0c4cd!8m2!3d43.7677856!4d11.2553108',
        imageUrl: 'assets/images/Uffizi.png'),
    Museum(
        id: '5',
        name: 'Brera',
        address: 'Via Brera 28, Milano, Italy',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 30,
        imageUrl: 'assets/images/Brera.png',
        location:
            'https://www.google.com/maps/place/Brera/@45.4719582,9.1856258,17z/data=!3m1!4b1!4m5!3m4!1s0x4786ee11587e4e1f:0x1b367a8e2cb13736!8m2!3d45.4719545!4d9.1878145'),
    Museum(
        id: '6',
        name: 'Museum Egizio',
        address: 'Via Accademia delle Scienze 6, Torino, Italy',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 30,
        imageUrl: 'assets/images/Egizio.png',
        location:
            'https://www.google.com/maps/place/Museo+Egizio,+Castello+Sforzesco,+Piazza+Castello,+Milano,+Metropolitan+City+of+Milan,+Italija/@45.4719582,9.1856258,17z/data=!4m5!3m4!1s0x4786c14df358bf37:0x5b7124c3b265c967!8m2!3d45.471013!4d9.1798188'),
  ];
  Future<void> fetchMuseums() async {
    List<Museum> loadedMuseums = [];
    _museums.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("museums").get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      loadedMuseums.add(Museum(
        id: doc.id,
        name: data["name"],
        address: data["address"],
        description: data["description"],
        imageUrl: data["imageUrl"],
        location: data["location"],
        tourDuration: data["tourDuration"],
      ));
    }
    _museums = loadedMuseums;
    notifyListeners();
  }

  List<Museum> get getMuseums {
    print(_museums.length);
    return [..._museums];
  }

  List<Museum> searchMuseums(String query) {
    return _museums.where((museum) {
      final titleLower = museum.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();
  }

  double getMuseumTourDuration(String museumId) {
    return _museums
        .firstWhere((museumData) => museumData.id == museumId)
        .tourDuration;
  }

  Museum getById(String id) {
    return _museums.firstWhere((museum) => museum.id == id);
  }

  List<Museum> filterMusemsByCategory(String categoryId) {
    if (categoryId == 'c0') {
      return _museums;
    }
    artworks.fetchAndSetArtworks();
    List<Artwork> categoryArtworks = artworks.getByCategory(categoryId);
    //print('Broj artworka: '+ categoryArtworks.length.toString());
    List<Museum> museumsFilter = [];
    for (Artwork artwork in categoryArtworks) {
      // print(artwork.name+'\n');
      museumsFilter
          .add(_museums.firstWhereOrNull((el) => el.id == artwork.museum));
    }
    return museumsFilter.toSet().toList();
  }

  void updateMuseum(Museum editedMuseum) {
    final museumIndex =
        _museums.indexWhere((museumData) => museumData.id == editedMuseum.id);
    if (museumIndex >= 0) {
      _museums[museumIndex] = editedMuseum;

      notifyListeners();
    }
  }
}
