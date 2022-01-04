// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import '../models/museum.dart';

final List<Museum> _museumList = [];

class Museums with ChangeNotifier {
  //mockup data of museums
  List<Museum> _museums = [
    Museum(
        id: '1',
        name: 'Gladiator Museum',
        address: 'Piazza Navona 90, Roma, Italie',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 45,
        imageUrl: 'assets/images/Gladiator.png'),
    Museum(
        id: '2',
        name: 'Doria Pamhili Gallery',
        address: 'Via del Corso 305, Roma, Italie',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 50,
        imageUrl: 'assets/images/Doria_Pamphili.png'),
    Museum(
        id: '3',
        name: 'Capitoline Museum',
        address: 'Piazza del Campidoglio 1, Roma, Italie',
        description:
            'The exposition represents an itinerary through history going from the VII century B.C. to the IV century A.D. brought to life through the accurate reconstruction of helmets and armour of the Roman legions and gladiators, showing over a millenium of history through the most representative weaponry of Roman army and its enemies. Set on two floors, in the basement there is the chance to see and touch the autentique columns of the ancient Stadium of Domitian and to take photos into the gladiators’ prison.',
        tourDuration: 30,
        imageUrl: 'assets/images/Capitolini.png'),
  ];
  
  //getter that returns all museum in the list
  List<Museum> get getMuseums{
    return [... _museums];
  }

}
