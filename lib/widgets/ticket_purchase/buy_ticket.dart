import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/models/artwork.dart';
import 'package:museum_app/providers/artworks.dart';
import 'package:provider/provider.dart';

import '../homepage/search_bar.dart';
import '../../models/museum.dart';
import '../../providers/museums.dart';
import '../../widgets/homepage/dropdown_category.dart';
import './buy_ticket_single_museum.dart';
import '../../providers/work_times.dart';

class BuyTicket extends StatefulWidget {
  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  List<Museum> museumsForWidget = [];
  List<Museum> mainMuseumList = [];
  List<Museum> museumsSearchSelectedCategory;
  String query = '';
  String category = 'c0';

  void searchMuseum(String queryText) {
    setState(() {
      List<Museum> searchMuseum =
          museumsSearchSelectedCategory ?? mainMuseumList;
      query = queryText;
      museumsForWidget = searchMuseum.where((museum) {
        final titleLower = museum.name.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  void didChangeDependencies() {
    mainMuseumList = Provider.of<Museums>(context, listen: false).getMuseums;
    museumsForWidget = mainMuseumList;
    super.didChangeDependencies();
  }

  void searchMuseumByCategory(String categoryId) {
    setState(() {
      category = categoryId;
      if (categoryId != 'c0') {
        List<Artwork> categoryArtworks =
            Provider.of<Artworks>(context, listen: false)
                .getByCategory(categoryId);
        List<Museum> museumsFilter = [];
        for (Artwork artwork in categoryArtworks) {
          museumsFilter.add(
              mainMuseumList.firstWhereOrNull((el) => el.id == artwork.museum));
        }
        museumsForWidget = museumsFilter.toSet().toList();
        museumsSearchSelectedCategory = museumsForWidget;
      } else {
        museumsForWidget = mainMuseumList;
        museumsSearchSelectedCategory = null;
      }
    });
  }

  int itemCounter = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropDownCategory(searchMuseumByCategory),
                    FittedBox(
                        fit: BoxFit.contain, child: SearchBar(searchMuseum)),
                  ],
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              museumsForWidget.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(
                        'assets/images/NoArtworks.png',
                        fit: BoxFit.fill,
                      ))
                  : SizedBox(
                      height: constraints.maxHeight * 0.82,
                      child: ListView.builder(
                        itemCount: museumsForWidget.length,
                        itemBuilder: (_, i) {
                          bool museumHaveWorkTime =
                              Provider.of<WorkTimes>(context)
                                  .ifTheWorkTimeExist(museumsForWidget[i].id);
                          if (museumHaveWorkTime) {
                            itemCounter++;
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (museumHaveWorkTime)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: BuyTicketSingleMuseum(
                                        museumsForWidget[i], itemCounter),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
