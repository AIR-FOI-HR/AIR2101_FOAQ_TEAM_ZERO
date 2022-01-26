import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homepage/search_bar.dart';
import '../../models/museum.dart';
import '../../providers/museums.dart';
import '../../widgets/homepage/dropdown_category.dart';

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
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropDownCategory(searchMuseumByCategory),
              SearchBar(searchMuseum),
            ],
          ),
        ],
      ),
    );
  }
}
