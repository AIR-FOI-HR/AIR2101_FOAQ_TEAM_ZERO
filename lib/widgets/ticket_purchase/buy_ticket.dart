import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homepage/search_bar.dart';
import '../../models/museum.dart';
import '../../providers/museums.dart';
import '../../widgets/homepage/dropdown_category.dart';
import './buy_ticket_single_museum.dart';

class BuyTicket extends StatefulWidget {
  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  List<Museum> museumsForWidget;
  List<Museum> mainMuseumList;
  String query = '';
  String category = 'c0';

  void searchMuseum(String query) {
    setState(() {
      this.query = query;
      this.museumsForWidget = mainMuseumList.where((museum) {
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
      this.category = categoryId;
      this.mainMuseumList = Provider.of<Museums>(context, listen: false)
          .filterMusemsByCategory(categoryId);
      museumsForWidget = mainMuseumList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropDownCategory(searchMuseumByCategory),
                    SearchBar(searchMuseum),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.03),
                museumsForWidget.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/images/NoArtworks.png',
                          fit: BoxFit.fill,
                        ))
                    : SizedBox(
                        height: constraints.maxHeight * 0.82,
                        child: ListView.builder(
                          itemCount: museumsForWidget.length,
                          itemBuilder: (_, i) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuyTicketSingleMuseum(museumsForWidget[i]),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
